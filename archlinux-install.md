# ArchLinux 配置文档

## 创建新用户

### 创建用户

```bash
useradd -m yunus    # 新增用户
passwd yunus        # 设置用户密码
```

###  授予 sudo 权限

使用 `EDITOR=nano visudo` 命令，在文件末尾增加如下行：

```sudoers
yunus ALL=(ALL:ALL) ALL
```

### 切换用户

使用 `su - yunus` 切换用户，或 `logout` 登出后使用新用户登录。

---

## 更新系统

```bash
sudo pacman -Syuu
```

---

## 安装基础工具

### 网络

| 软件包 | 说明 |
|--------|------|
| `networkmanager` | 网络连接管理器 |
| `iwd` | 无线网络连接 (WiFi) |
| `dhcpcd` | 自动获取 IP 地址 |
| `net-tools` | 网络工具集 |
| `openbsd-netcat` | `nc` 网络工具 |
| `autossh` | 自动 SSH 端口转发、内网穿透 |
| `lftp` | FTP 客户端（Dolphin 内置 FTP 但无 Dolphin 时仍需通用客户端） |

### 编辑器

| 软件包 | 说明 |
|--------|------|
| `vim` | 通用终端编辑器（可从源码编译） |
| `gvim` | Vim 的 GUI 版本（可选） |
| `emacs` | 强大编辑器，依赖其 Org-Mode（可选） |
| `helix` | Rust 编写的轻量终端编辑器 |
| `nano` | 轻量非模式终端编辑器 |
| `ed` | 原始的行编辑器 |
| `zed` | Rust 实现的全能轻量编辑器 |
| `typora-free` | Markdown 编辑器（AUR） |

### Shell & 终端工具

| 软件包 | 说明 |
|--------|------|
| `zsh` | 功能更丰富的 Shell |
| `tmux` | 终端复用工具 |
| `dtach` / `dvtm` | 更轻量的终端复用/平铺窗口工具 |
| `foot` | 终端模拟器（资源占用低，可选） |
| `konsole` | KDE 环境终端模拟器 |
| `rofi` | 程序启动器（已支持 Wayland） |

### 文件管理

| 软件包 | 说明 |
|--------|------|
| `yazi` | 终端文件管理器 |
| `vifm` | Vim 风格文件管理器 |
| `nnn` | 极简文件管理器 |
| `dolphin` | KDE 环境文件管理器 |

### 搜索与文本处理

| 软件包 | 说明 |
|--------|------|
| `ripgrep` (`rg`) | 代码库文本搜索（Rust 实现，优于 grep） |
| `the_silver_searcher` (`ag`) | 文本搜索工具（优于 grep） |
| `fd` | 文件搜索（比 find 更友好） |
| `fzf` | 模糊搜索工具 |
| `bat` | `cat` 的上位替代（语法高亮等） |
| `jq` | JSON 格式化工具 |
| `ctags` | 生成 tags 文件 |
| `astyle` | 代码格式化 |
| `less` | 分页查看文本文档 |

### 开发工具

| 软件包 | 说明 |
|--------|------|
| `git` | 版本管理 |
| `curl` / `xh` | HTTP 客户端（`xh` 兼容 httpie 语法，Rust 实现） |
| `python` | 通用脚本语言 |
| `nodejs` | Node 环境，用于运行语言服务器 |
| `sbcl` | Steel Bank Common Lisp 解释器 |
| `rlwrap` | REPL 包装器 |
| `binsider` | 二进制分析工具 |

### 系统工具

| 软件包 | 说明 |
|--------|------|
| `polkit` | 现代化特权授权工具 |
| `fastfetch` | 展示系统信息 |
| `bc` | 基础计算器 |
| `bottom` | 任务管理器（top 的替代，更友好直观） |
| `sc-im` | 终端表格处理工具（Vim 风格交互） |
| `mdp` | 终端文稿演示工具（类似 PPT） |

### 加密工具

| 软件包 | 说明 |
|--------|------|
| `age` | 通用文件加密工具 |

### 字体

| 软件包 | 说明 |
|--------|------|
| `noto-fonts-cjk` | 中文字体包 |

### 容器与虚拟化

| 软件包 | 说明 |
|--------|------|
| `podman` | 容器引擎（优先选择） |
| `fuse-overlayfs` | Podman 依赖（不使用 Podman 可跳过） |
| `docker` | 容器引擎（备选） |
| `qemu` | 虚拟机 |
| `qemu-ui-curses` | QEMU 终端模式 UI |

### 桌面环境 (KDE)

| 软件包 | 说明 |
|--------|------|
| `plasma` | KDE 桌面环境（可选，也可用窗口管理器） |
| `sddm` | 登录管理器（可选，可直接在 tty 启动 WM/DE） |
| `ark` | KDE 解压缩工具 |
| `konsole` | KDE 终端模拟器 |
| `flatpak` | 软件沙盒环境 |

### 窗口管理器 (Wayland)

| 软件包 | 说明 |
|--------|------|
| `niri` | 卷轴式平铺窗口管理器 |

### Wayland 组件

| 软件包 | 说明 |
|--------|------|
| `xdg-desktop-portal` | 桌面门户服务 |
| `xdg-desktop-portal-wlr` | Wayland 默认 xdg-desktop-portal 后端 |
| `xdg-desktop-portal-gtk` | GTK 后端（文件选择器等功能依赖） |
| `gnome-keyring` | 密钥环与 Secret portal 后端 |
| `mako` | Wayland 桌面通知组件 |
| `swayidle` | 空闲管理器 |
| `swaylock` | 锁屏 |
| `wlopm` | Wayland 通用系统工具（用于熄屏） |
| `wlr-randr` | Wayland 显示器管理 |
| `xorg-xrandr` | X11 显示器管理（SDDM 依赖） |
| `xwayland-satellite` | Niri 依赖的 XWayland 支持 |
| `swaybg` | 窗口管理器背景图 |
| `chafa` | 终端图片查看器 |
| `waybar` | 状态栏 |
| `wl-clipboard` | Wayland 剪切板 |
| `wtype` | Wayland 键盘模拟器 |
| `grim` | 截图工具 |
| `slurp` | 配合 grim 区域截图 |

### 输入法

| 软件包 | 说明 |
|--------|------|
| `fcitx5` | 输入法框架 |
| `fcitx5-chinese-addons` | 中文扩展 |
| `fcitx5-cn-meta` | 中文元包 |
| `fcitx5-qt` | Qt 支持 |
| `fcitx5-gtk` | GTK 支持 |
| `fcitx5-configtool` | 输入法配置工具 |

### 浏览器

| 软件包 | 说明 |
|--------|------|
| `firefox` | 浏览器（资源占用较 Chrome 低） |
| `google-chrome` | Chrome 浏览器（AUR） |

### 代理工具

| 软件包 | 说明 |
|--------|------|
| `mihomo` | 代理工具内核 |

### AUR 包管理器

| 软件包 | 说明 |
|--------|------|
| `paru` | AUR 包管理器（Rust 实现，优先使用） |
| `yay` | AUR 包管理器（Go 实现，可选备选） |

---

## 其他注意事项

### 配置 age 加密工具

安装 age：

```bash
sudo pacman -S age
```

首次配置时生成原生 age 密钥：

```bash
mkdir -p ~/.config/age
chmod 700 ~/.config/age
age-keygen -o ~/.config/age/keys.txt
chmod 600 ~/.config/age/keys.txt
```

age 是独立于具体应用的通用工具。多台设备使用同一套密钥时，通过密码管理器或
离线介质安全复制 `keys.txt`，切勿将私钥或明文敏感数据提交到配置仓库。需要同步
加密数据时，建议使用独立的私密数据仓库。

### NetworkManager 使用 iwd 作为 WiFi 后端

推荐组合：由 NetworkManager 统一管理网络连接，WiFi 后端切换为 iwd。这样桌面环境、`nmcli`、`nmtui` 等工具仍然走 NetworkManager，但底层无线连接由 iwd 处理。

安装必要包：

```bash
sudo pacman -S networkmanager iwd
```

创建 NetworkManager 配置：

```bash
sudo mkdir -p /etc/NetworkManager/conf.d
sudoedit /etc/NetworkManager/conf.d/wifi_backend.conf
```

写入以下内容：

```ini
[device]
wifi.backend=iwd
```

启用 NetworkManager：

```bash
sudo systemctl enable --now NetworkManager.service
sudo systemctl restart NetworkManager.service
```

如果之前启用了独立的 `wpa_supplicant` 或 `iwd` 服务，建议停用，避免多个网络管理服务同时接管 WiFi：

```bash
sudo systemctl disable --now wpa_supplicant.service
sudo systemctl disable --now iwd.service
```

之后使用 NetworkManager 管理连接：

```bash
nmcli device wifi list
nmtui
```

### XWayland 及 Java 程序的环境变量

启动程序时携带环境变量，或写入 `/etc/environment`（不建议直接写入，会污染全局环境）：

```ini
GDK_SCALE=1                      # 缩放
XCURSOR_SIZE=24                  # 光标大小
GTK_IM_MODULE=fcitx              # 输入法 (GTK)
QT_IM_MODULE=fcitx               # 输入法 (Qt)
XMODIFIERS=@im=fcitx             # 输入法
_JAVA_AWT_WM_NONREPARENTING=1    # Java 应用配置
```

### 安装 Chrome 浏览器

```bash
paru -S google-chrome              # AUR
flatpak install com.google.Chrome  # Flatpak
```

### Typora 安装与主题配置

Typora 可通过 AUR 安装：

```bash
paru -S typora-free
```

`update.sh` 会自动将 `typora/theme/opencode.css` 复制到 `~/.config/Typora/themes/`，启动 Typora 后可在菜单 `主题 → opencode` 中切换。

### 安装 Mihomo 网络代理服务

`~/.config/mihomo` 目录下有一个 `install-mihomo-service.sh` 脚本，执行即可安装并启动代理服务。修改 `config.yaml` 填入订阅链接，安装服务后启动代理。

### XWayland 应用在高分屏下模糊

XWayland 仅在整数倍缩放下才能清晰显示。两种方案：

- **方案一**：设置整数倍缩放，但字体会非常小。
- **方案二**：使用多显示器，XWayland 应用运行在普通分辨率显示器上（缩放 = 1）。但可能导致光标偏移（显示位置与实际位置不符），大多数 WM 有此问题，KDE 不受影响。

### XWayland 应用中 Fcitx5 候选框大小异常

编辑 `~/.Xresources`，新增以下行后重启（或用 `xrdb -merge ~/.Xresources` 重新加载）：

```Xresources
Xft.dpi=192
```

### 非 KDE 环境中 File Picker 无法使用

Wayland 默认 xdg-desktop-portal 后端 (`xdg-desktop-portal-wlr`) 不支持 file-picker。GTK 应用需额外安装 GTK 后端：

```bash
sudo pacman -S xdg-desktop-portal-gtk
systemctl --user restart xdg-desktop-portal.service
```

### Niri 会话中的 Secret Portal

部分桌面应用会通过 xdg-desktop-portal 的 Secret 接口保存登录凭据，例如 Zed 的账户登录状态。如果 Niri 会话没有可用的 Secret portal，应用可能每次启动都要求重新登录。

安装 `gnome-keyring`，它同时提供 `org.freedesktop.secrets` 服务和 `gnome-keyring` Secret portal 后端：

```bash
sudo pacman -S gnome-keyring
```

仓库中的 `.config/xdg-desktop-portal/niri-portals.conf` 指定 Niri 会话使用 GTK 作为默认 portal，并使用 gnome-keyring 处理 Secret 接口：

```ini
[preferred]
default=gtk
org.freedesktop.impl.portal.Settings=none
org.freedesktop.impl.portal.FileChooser=gtk
org.freedesktop.impl.portal.Secret=gnome-keyring
```

Niri 启动时需要把 `XDG_CURRENT_DESKTOP=niri` 导入 systemd/DBus 激活环境，让 xdg-desktop-portal 正确读取 `niri-portals.conf`：

```kdl
spawn-at-startup "dbus-update-activation-environment" "--systemd" "WAYLAND_DISPLAY" "XDG_CURRENT_DESKTOP=niri"
```

修改配置后重启 Niri 会话，或重启用户级 portal 服务：

```bash
systemctl --user restart xdg-desktop-portal.service
```

### 桌面用户 DBus 使用 Polkit 认证

在 `/etc/polkit-1/rules.d/49-nopasswd-global.rules` 中添加（将 `yunus` 替换为实际用户名）：

```javascript
polkit.addRule(function(action, subject) {
    if (subject.isInGroup("yunus")) {
        return polkit.Result.YES;
    }
});
```

### SDDM 多显示器配置

**开启 HiDPI** — `/etc/sddm.conf.d/hidpi.conf`：

```ini
[Wayland]
EnableHiDPI=true

[X11]
EnableHiDPI=true

[General]
GreeterEnvironment=QT_SCREEN_SCALE_FACTORS=2,QT_FONT_DPI=192
```

**单显示器登录** — `/usr/share/sddm/scripts/Xsetup`（根据实际调整）：

```bash
xrandr --output eDP-1 --mode 2880x1800 --output DP-2 --off
```

### Podman 报错 "kernel does not support overlay fs"

安装 `fuse-overlayfs` 即可。

### Electron 应用启用 Wayland 及输入法

优先检查应用文档、包装脚本或发行包说明中是否提供了 flags 配置方式。常见形式包括 `~/.config/*-flags.conf`，但这不是 Electron/Chromium 通用规范，只有应用明确支持时才会读取。

可用下面的方式静态检查启动脚本是否读取 flags 文件：

```bash
file "$(command -v example)"
sed -n '1,120p' "$(command -v example)"
```

如果确认支持，将应用文档指定的 flags 配置文件写入：

```conf
--ozone-platform=wayland
--enable-wayland-ime
--wayland-text-input-version=3
```

如果应用没有文档支持、没有包装脚本读取配置文件，或配置文件方式实际无效，再使用用户级 `.desktop` 文件覆盖系统启动项作为兜底方案。

复制系统 desktop 文件到用户目录后修改：

```bash
cp /usr/share/applications/example.desktop ~/.local/share/applications/example-wayland.desktop
```

将 `Exec=` 改为类似下面的形式，注意参数放在 `%U`、`%u`、`%F`、`%f` 之前：

```
Exec=/usr/bin/example --ozone-platform=wayland --enable-wayland-ime --wayland-text-input-version=3 %U
```

注意：

- `--wayland-text-input-version` 需要显式指定版本号。fcitx5 在 KDE/Plasma Wayland 下通常使用 `3`。
- `--ozone-platform-hint=auto` 只表示自动选择平台；输入法异常时，用 `--ozone-platform=wayland` 强制走原生 Wayland 更容易排查。
- 要求 Electron/Chromium runtime 支持 Wayland IME。部分应用使用自带定制 runtime，升级后可能回归；此时可临时退回 XWayland，并依赖 `XMODIFIERS=@im=fcitx` 等输入法环境变量。
- 例如 Mihomo Party 文档说明会读取 `~/.config/mihomo-party/mihomo-party-flags.conf`；AUR `feishu-bin` 的 `/usr/bin/feishu` 会读取 `~/.config/feishu-flags.conf`；AUR `typora` 的 `/usr/bin/typora` 会读取 `~/.config/typora-flags.conf`。
