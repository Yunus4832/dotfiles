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
| `Zed` | Rust 实现的全能轻量编辑器 |
| `typora` | Markdown 编辑器（AUR `typora-free`） |

### Shell & 终端工具

| 软件包 | 说明 |
|--------|------|
| `zsh` | 功能更丰富的 Shell |
| `tmux` | 终端复用工具 |
| `dtash` / `dvtm` | 更轻量的终端复用/平铺窗口工具 |
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
| `more`/`less` | 分页查看文本文档 |

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

### 字体

| 软件包 | 说明 |
|--------|------|
| `font` | 中文字体包 |

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
| `river` | 轻量窗口管理器（Tag 组织窗口） |
| `niri` | 卷轴式平铺窗口管理器 |

### Wayland 组件

| 软件包 | 说明 |
|--------|------|
| `xdg-desktop-portal-wlr` | Wayland 默认 xdg-desktop-portal 后端 |
| `xdg-desktop-portal-gtk` | GTK 后端（文件选择器等功能依赖） |
| `gnome-keyring` | Niri 依赖的密钥环 |
| `mako` | Wayland 桌面通知组件 |
| `swayidle` | 空闲管理器 |
| `swaylock` | 锁屏 |
| `wlopm` | Wayland 通用系统工具（River 依赖其熄屏） |
| `wlr-randr` | Wayland 显示器管理（River 依赖） |
| `xorg-xrandr` | X11 显示器管理（SDDM 依赖） |
| `xwayland-satellite` | Niri 依赖的 XWayland 支持 |
| `swaybg` | 窗口管理器背景图 |
| `swayimg` | 图片查看器 |
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
| `mihomo-party` | Mihomo GUI 管理器 |

### AUR 包管理器

| 软件包 | 说明 |
|--------|------|
| `paru` | AUR 包管理器（Rust 实现，优先使用） |
| `yay` | AUR 包管理器（Go 实现，可选备选） |

---

## 其他注意事项

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

启动时追加参数：

```
--ozone-platform-hint=auto --enable-wayland-ime
```

要求 Electron >= 28。

### Mihomo Party 启用 Wayland

将 `mihomo-party-flags.conf` 写入 `~/.config/mihomo-party`：

```conf
--ozone-platform-hint=auto
--enable-wayland-ime
```
