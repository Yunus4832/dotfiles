#!/usr/bin/env bash

set -u

need() {
    command -v "$1" >/dev/null 2>&1
}

json_escape() {
    jq -Rn --arg value "$1" '$value'
}

waybar_json() {
    local text="$1"
    local tooltip="$2"
    local class="$3"

    printf '{"text":%s,"tooltip":%s,"class":%s}\n' \
        "$(json_escape "$text")" \
        "$(json_escape "$tooltip")" \
        "$(json_escape "$class")"
}

wifi_device() {
    nmcli -t -f DEVICE,TYPE device status 2>/dev/null | awk -F: '$2 == "wifi" { print $1; exit }'
}

wifi_status() {
    if ! need nmcli || ! need jq; then
        waybar_json "WiFi ?" "Missing dependency: nmcli or jq" "missing"
        return
    fi

    if ! nmcli general status >/dev/null 2>&1; then
        waybar_json "WiFi ?" "NetworkManager is unavailable" "missing"
        return
    fi

    local device radio active_line ssid signal state tooltip

    device="$(wifi_device)"
    if [ -z "$device" ]; then
        waybar_json "WiFi -" "No Wi-Fi device found" "missing"
        return
    fi

    radio="$(nmcli radio wifi 2>/dev/null)"
    if [ "$radio" != "enabled" ]; then
        waybar_json "WiFi off" "Wi-Fi radio is disabled" "disabled"
        return
    fi

    state="$(nmcli -t -f GENERAL.STATE device show "$device" 2>/dev/null | cut -d: -f2-)"
    if ! printf '%s' "$state" | grep -qi "connected"; then
        waybar_json "WiFi ..." "Wi-Fi is enabled, not connected" "disconnected"
        return
    fi

    active_line="$(nmcli -t -f ACTIVE,SSID,SIGNAL dev wifi list --rescan no 2>/dev/null | awk -F: '$1 == "yes" { print; exit }')"
    ssid="$(printf '%s' "$active_line" | cut -d: -f2 | sed 's/\\:/:/g; s/\\\\/\\/g')"
    signal="$(printf '%s' "$active_line" | cut -d: -f3)"

    if [ -z "$ssid" ]; then
        ssid="$(nmcli -t -f GENERAL.CONNECTION device show "$device" 2>/dev/null | cut -d: -f2- | sed 's/\\:/:/g; s/\\\\/\\/g')"
    fi

    tooltip="Connected to ${ssid:-unknown}"
    if [ -n "$signal" ]; then
        tooltip="$tooltip (${signal}%)"
    fi

    if [ -n "$signal" ]; then
        waybar_json "󰤨 ${signal}%" "$tooltip" "connected"
    else
        waybar_json "󰤨 up" "$tooltip" "connected"
    fi
}

rofi_pick() {
    local prompt="$1"
    rofi -dmenu -i -markup-rows -no-custom -format 'i' -p "$prompt" \
        -theme-str 'window { width: 560px; }' \
        -theme-str 'listview { lines: 10; }' \
        -theme-str '* { font: "Consolas 7NF 12"; }' \
        -theme-str 'element { padding: 9px 14px; }'
}

notify() {
    if need notify-send; then
        notify-send "Wi-Fi" "$1"
    fi
}

known_connection() {
    local ssid="$1"
    nmcli -t -f NAME,TYPE connection show | awk -F: -v ssid="$ssid" '$2 == "802-11-wireless" && $1 == ssid { found = 1 } END { exit !found }'
}

connect_wifi() {
    local ssid="$1"
    local security="$2"

    if known_connection "$ssid"; then
        nmcli connection up "$ssid" >/dev/null 2>&1 && notify "Connected to $ssid" && return
    fi

    if [ -n "$security" ] && [ "$security" != "--" ]; then
        local password
        password="$(rofi -dmenu -password -p "Password for $ssid")"
        [ -z "$password" ] && return
        nmcli device wifi connect "$ssid" password "$password" >/dev/null 2>&1 && notify "Connected to $ssid" && return
    else
        nmcli device wifi connect "$ssid" >/dev/null 2>&1 && notify "Connected to $ssid" && return
    fi

    notify "Failed to connect to $ssid"
}

wifi_menu() {
    if ! need nmcli || ! need rofi; then
        notify "Missing dependency: nmcli or rofi"
        exit 1
    fi

    local device radio rows row_index selected action ssid security

    device="$(wifi_device)"
    [ -z "$device" ] && notify "No Wi-Fi device found" && exit 1

    radio="$(nmcli radio wifi 2>/dev/null)"
    if [ "$radio" = "enabled" ]; then
        rows="<span foreground='#88c0d0'>󰖩</span>  Rescan	rescan	
<span foreground='#ebcb8b'>󰤮</span>  Disconnect	disconnect	
<span foreground='#bf616a'>󰖪</span>  Turn Wi-Fi off	wifi-off	"
    else
        rows="<span foreground='#a3be8c'>󰖩</span>  Turn Wi-Fi on	wifi-on	"
    fi

    rows="${rows}
$(
        if [ "$radio" = "enabled" ]; then
            nmcli device wifi rescan >/dev/null 2>&1
            nmcli -t -f ACTIVE,SSID,SIGNAL,SECURITY device wifi list --rescan no |
                awk -F: '
                    $2 != "" && !seen[$2]++ {
                        active = ($1 == "yes") ? "●" : "○"
                        security = ($4 == "" ? "--" : $4)
                        gsub(/\\:/, ":", $2)
                        gsub(/\\\\/, "\\", $2)
                        lock = (security == "--") ? "󰖩" : "󰌾"
                        color = ($1 == "yes") ? "#a3be8c" : "#7e8fa6"
                        printf "<span foreground=\"%s\">%s</span>  <span foreground=\"#7e8fa6\">%3s%% %s</span>  %s\tssid:%s\t%s\n", color, active, $3, lock, $2, $2, security
                    }
                '
        fi
    )"

    rows="$(printf '%s\n' "$rows" | sed '/^$/d')"
    row_index="$(printf '%s\n' "$rows" | cut -f1 | rofi_pick "Wi-Fi")"
    [ -z "$row_index" ] && exit 0

    selected="$(printf '%s\n' "$rows" | sed -n "$((row_index + 1))p")"
    action="$(printf '%s' "$selected" | awk -F'\t' '{ print $2 }')"
    security="$(printf '%s' "$selected" | awk -F'\t' '{ print $3 }')"

    case "$action" in
        wifi-on)
            nmcli radio wifi on
            ;;
        wifi-off)
            nmcli radio wifi off
            ;;
        disconnect)
            nmcli device disconnect "$device"
            ;;
        rescan)
            nmcli device wifi rescan
            ;;
        *)
            ssid="${action#ssid:}"
            [ -n "$ssid" ] && connect_wifi "$ssid" "$security"
            ;;
    esac
}

case "${1:-status}" in
    menu)
        wifi_menu
        ;;
    status|*)
        wifi_status
        ;;
esac
