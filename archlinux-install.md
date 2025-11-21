# ArchLinux 安装文档

## 安装 ArchLinux

### VirtualBox 虚拟机安装

### 物理机安装

## 创建新用户

1. 创建新用户

   ```bash
   # 新增用户
   useradd -m yunus

   # 设置用户密码
   passwd yunus
   ```

2. 赋予用户 sudo 权限, 使用 `EDITOR=nano visudo` 命令，并在打开的文件末尾增加如下行

   ```sudoers
   yunus ALL=(ALL:ALL) ALL
   ```

3. 切换用户, 使用 `su - yunus` 切换用户，或者 `logout` 登出，然后使用新用户登录

## 更新系统

执行如下命令：

```bash
sudo pacman -Syuu
```

## 安装基础工具

1. 常用的终端和 GUI 程序列表如下

   ```plain-text
   iwd -- 连接无线网络 wifi
   dhcpcd -- 自动获取 ip 地址

   vim -- 通用编辑器
   gvim -- Vim 的 GUI 版本，可选
   emacs -- 另一个强大的通用编辑器，本人比较依赖其 Org-Mode, 可选
   git -- 版本管理工具
   fzf -- 模糊搜索工具
   curl -- 终端 http 客户端
   xh -- Rust 编写的 http 客户端，比 curl 更加友好, 兼容 httpie 但是不依赖 python
   ctags -- 用于生成 tags 文件
   astyle -- 格式化代码
   jq -- json 格式化工具
   ranger -- 文件管理器
   vifm -- 另一个简单的文件管理器
   more/less -- 分页查看文本文档，类似 cat
   bat -- cat 的上位替代
   zsh -- 更好用的 shell
   tmux -- 终端复用工具
   dtash -- 另一个更轻量级的终端复用工具
   dvtm -- 另一个轻量级的终端平铺窗口工具
   polkit -- 现代化的特权授权工具
   ripgrep -- rg 文本搜索工具，rust 语言实现，对于代码库中的搜索，优于 grep
   the_silver_searcher -- ag 另一个文本搜索工具，优于 grep
   fd -- 文件搜索工具，比 find 更加友好
   net-tools -- 网络工具
   fastfetch -- 展示系统相关信息
   bc -- 基础的计算器
   ed -- 基础的编辑器
   openbsd-netcat -- nc 网络工具
   autossh -- 自动 ssh 端口转发实现内网穿透的工具
   lftp -- ftp 文件服务器客户端，虽然 dolphin 内置 ftp 支持，但是如果没有 dolphin 仍然需要一个通用的 ftp 客户端
   bottom -- 任务管理器，top 的替代，比 top 更加友好直观

   font -- 中文字体

   sddm -- 登录管理器，可选，可以直接在 tty 中输入命令启动窗口管理器后 DE

   plasma -- KDE 桌面环境，可选，也可使用窗口管理器
   ark -- KDE 环境解压缩工具
   dolphin -- KDE 环境文件管理器
   konsole -- KDE 环境终端模拟器
   flatpak -- 软件沙盒环境

   sway -- 窗口管理器, 资源占用较小, 可用性不如 KDE, 存在许多 xwayland 应用难以解决的小问题，例如输入法配置, 字体模糊等
   river -- 另一个轻量级窗口管理噐，使用 tag 而不是 workspace 组织窗口，问题同 Sway
   hyprland -- 注重视觉效果的窗口管理噐，一定程度上解决了 xwayland 应用的模糊问题，视觉效果非常好～
   niri -- 另一个卷轴式的平铺窗口管理器，高效易用，但是对部分应用，尤其是 Electron 应用的输入法支持不是很好

   xdg-desktop-protal-wlr -- wayland 环境默认的 xdg-desktop-portal 后端。
   xdg-desktop-portal-gtk -- 部分软件包依赖 xdg-desktop-portal 的 gtk 后端，例如文件选择噐等功能
   mako -- wayland 协议的桌面通知组件

   hypridle -- hyprland 生态的空闲管理器
   hyprlock -- hyprland 生态锁屏
   swayidle -- sway 生态的空闲管理器，可选，优先 hypridle
   swaylock | swaylock-effects -- sway 生态锁屏, effects 带特殊效果，可选，优先 hyprlock
   wlopm -- wayland 环境通用的系统工具, river 依赖其进行熄屏
   wlr-randr -- waylany 环境中的显示器管理工具, river 依赖其设置显示器参数
   xorg-xrandr -- X11 环境中设置显示器参数工具，sddm 依赖其设置多显示器的布局
   xwayland-satellite -- niri 依赖该软件包支持 xwayland 应用

   swaybg -- 窗口管理器背景图
   swayimg -- 查看图片
   foot -- 终端模拟器, 可选，konsole 也能用，但是 foot 资源占用更低
   rofi -- 程序启动器 rofi, 现在已支持 Wayland
   waybar -- 状态栏显示

   wl-clipboard -- wayland 协议的剪切板
   wtype -- wayland 环境中的键盘模拟器

   fcitx5 -- 输入法
   fcitx5-chinese-addons -- 输入法中文扩展
   fcitx5-cn-meta
   fcitx5-qt
   fcitx5-gtk
   fcitx5-configtool -- 输入法配置工具，如果使用 KDE 可不安装

   python -- 通用脚本语言
   nodejs -- node 环境，用于运行语言服务器

   chrome -- chrome 浏览器
   firefox -- firefox 浏览器，比 chrome 占用的资源更少

   mihomo -- 代理工具内核

   yay -- AUR 用户软件仓库包管理器

   sc-im -- 终端表格处理工具，交互类似 vim
   mdp -- 终端文稿演示工具，类似 PPT

   docker -- 容器引擎
   podman -- 容器引擎, 个人偏好 podman, 优先选择 podman
   fuse-overlayfs -- podman 依赖该软件包，不使用 podman 可选
   qemu -- 虚拟机软件
   qemu-ui-curses -- qemu 终端模式下的 UI

   binsider -- 二进制分析工具
   ```

## 其他注意事项

1. **XWayland 以及 Java 程序对于 Wayland 环境需要设置特殊的环境变量运行**

   ```environment
   # 启动时程序时携带环境变量，或者写入到 /etc/environment, 不建议直接写到该文件中，因为它是全局的环境变量，可能会污染其他应用程序
   # 缩放
   GDK_SCALE=1
   # 光标大小
   XCURSOR_SIZE=24
   # 输入法
   GTK_IM_MODULE=fcitx
   # 输入法
   QT_IM_MODULE=fcitx
   # 输入法
   XMODIFIERS=@im=fcitx
   # Java 应用配置环境变量
   _JAVA_AWT_WM_NONREPARENTING=1
   ```

2. **安装 chrome 浏览器**

   ```bash
   # 使用 AUR 软件包
   yay -S google-chrome
   # 使用 flatpak 软件包
   flatpak install com.google.Chrome
   ```

3. **安装 clash-verge-rev 代理工具**

   ```bash
   sudo pacman -S clash-meta-rev
   ```

4. **安装 mihomo 网络代理服务**

   在 `~/.config/mihomo` 目录下有一个可执行的 shell 脚本 `install-mihomo-service.sh` 能够安装和启动 mihomo 代理服务, 修改 `config.yaml` 将订阅填入，安装服务即可启动代理。

5. **解决 Chrome 在 wayland 会话下显示模糊的问题**

   打开 Chrome, 地址栏输入 `chrome://flags` 进入 Chrome 的实验室功能，搜索 `Preferred Ozone platform` 选择 `Auto` 即可

6. **GRUB 识别 window 系统**

   略

7. **GRUB 美化**

   略

8. **xwayland 应用在高分屏模糊问题**

   原因是高分屏对 xwayland 只有在整数倍的缩放下才能够清晰，因此可以选择设置显示器整数倍缩放，但是这样字体会十分小，另一个解决方案是多显示器方案，xwayland 应用运行在普通分辨率的显示器上，并且该显示器的缩放设置为 1，这样会带来另一个问题，即鼠标位置偏移，具体现象是光标显示位置和实际位置部分，体感上表现为无响应，大多数 WM 都有这个问题，KDE 可以正常使用。

9. **xwayland 应用中 fcitx5 候选框大小异常**

   编辑 `~/.Xresources` 文件，新增下列行，然后重启即可（或者使用 `xrdb -merge ~/.Xresources` 重新加载配置)

   ```.Xresources
   Xft.dpi=192
   ```

10. **非 KDE 环境中部分应用无法使用 xdg-desktop-portal 选取文件 file-picker**

    原因是 wayland 环境的默认 xdg-desktop-portal 后端 xdg-desktop-portal-wlr 在这些环境中还不支持 file-picker， 对于 gtk 的应用，需要额外安装并启用 gtk 的后端，具体命令如下：

    ```bash
    # 安装 gtk 的后端以支持选取文件
    sudo pacman -S xdg-desktop-portal-gtk
    # 重启主服务
    systemctl --user restart xdg-desktop-portal.service
    ```

11. **桌面用户 DBus 使用 polkit 进行认证**

    使用 polkit 进行认证，使用窗口管理器的用户如果需要静默授权需要使用增加如下规则到 `/etc/polkit-1/rules.d/49-nopasswd-global.rules` 中，用户修改成登陆用户：

    ```javascript
    polkit.addRule(function(action, subject){
        if(subject.isInGroup("yunus")){
            return polkit.Result.YES;
        }
    })
    ```

12. **SDDM 多显示器自定义配置，配置只使用主显示器登录，并且开启 HiDPI 支持**

    - `/etc/sddm.conf.d/hidpi.conf` 写入如下内容开启 HiDPI 支持

      ```conf
      [Wayland]
      EnableHiDPI=true

      [X11]
      EnableHiDPI=true

      [General]
      GreeterEnvironment=QT_SCREEN_SCALE_FACTORS=2,QT_FONT_DPI=192
      ```

    - `/usr/share/sddm/scripts/Xsetup` 添加如下内容设置 sddm 只使用一个显示器，需要根据实际情况调整

      ```conf
      xrandr --output eDP-1 --mode 2880x1800 --output DP-2 --off
      
      ```

13. **podman 相关命令提示 "kernel does not support overlay fs:'overlay'"**

    podman 依赖 fuse-overlayfs，安装对应软件包即可

