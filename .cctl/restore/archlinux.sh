#!/usr/bin/env bash
set -euo pipefail

asset_dir=$2
[ -r /etc/os-release ] || { printf 'cctl: cannot identify this distribution\n' >&2; exit 1; }
ID= ID_LIKE=
# shellcheck source=/dev/null
. /etc/os-release
[[ $ID == arch || " $ID_LIKE " == *' arch '* ]] || { printf 'cctl: archlinux restore requires Arch Linux or an Arch-based distribution\n' >&2; exit 1; }
command -v pacman >/dev/null || { printf 'cctl: pacman is required\n' >&2; exit 1; }

missing=() official=() aur=()
while IFS= read -r package || [ -n "$package" ]; do
    [[ -z $package || $package == \#* ]] && continue
    pacman -Q -- "$package" >/dev/null 2>&1 || missing+=("$package")
done < "$asset_dir/packages"

if [ "${#missing[@]}" -eq 0 ]; then
    printf 'cctl: base packages already installed\n' >&2
elif command -v paru >/dev/null; then
    paru -S --needed -- "${missing[@]}"
else
    for package in "${missing[@]}"; do
        if pacman -Si -- "$package" >/dev/null 2>&1; then official+=("$package"); else aur+=("$package"); fi
    done
    if [ "${#official[@]}" -gt 0 ]; then sudo pacman -S --needed -- "${official[@]}"; fi
    if [ "${#aur[@]}" -gt 0 ]; then
        printf 'cctl: AUR packages require paru: %s\n' "${aur[*]}" >&2
        exit 1
    fi
fi
