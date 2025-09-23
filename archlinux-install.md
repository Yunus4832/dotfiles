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

font -- 中文字体

plasma -- KDE 桌面环境，可选，也可使用窗口管理器
ark -- KDE 环境解压缩工具
dolphin -- KDE 环境文件管理器
konsole -- KDE 环境终端模拟器
flatpak -- 软件沙盒环境

sway -- 窗口管理器, 资源占用较小, 可用性不如 KDE, 存在许多 xwayland 应用难以解决的小问题，例如输入法配置, 字体模糊等
river -- 另一个轻量级窗口管理噐，使用 tag 而不是 workspace 组织窗口，问题同 Sway
hyprland -- 注重视觉效果的窗口管理噐，一定程度上解决了 xwayland 应用的模糊问题，视觉效果非常好～
xdg-desktop-protal-wlr -- wayland 环境默认的 xdg-desktop-portal 后端。
xdg-desktop-portal-gtk -- 部分软件包依赖 xdg-desktop-portal 的 gtk 后端，例如文件选择噐等功能

hypridle -- hyprland 生态的空闲管理器
hyprlock -- hyprland 生态锁屏
swayidle -- sway 生态的空闲管理器，可选，优先 hypridle
swaylock | swaylock-effects -- sway 生态锁屏, effects 带特殊效果，可选，优先 hyprlock
wlopm -- wayland 环境通用的系统工具, river 依赖其进行熄屏

swaybg -- 窗口管理器背景图
swayimg -- 查看图片
foot -- 终端模拟器, 可选，konsole 也能用，资源占用更低
rofi -- 程序启动器 rofi, 现在已支持 Wayland
waybar -- 状态栏显示

wl-clipboard -- wayland 协议的剪切板

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

clash-meta -- 代理工具内核
clash-verge-rev -- 代理工具, clash-meta 会被作为依赖自动安装

yay -- AUR 用户软件仓库包管理器

sc-im -- 终端表格处理工具，交互类似 vim
```

## 其他注意事项

1. XWayland 以及 Java 程序对于 Wayland 环境需要设置特殊的环境变量运行

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

2. 安装 chrome 浏览器

   ```bash
   # 使用 AUR 软件包
   yay -S google-chrome
   # 使用 flatpak 软件包
   flatpak install com.google.Chrome
   ```

3. 安装 clash-verge-rev 代理工具

   ```bash
   sudo pacman -S clash-meta-rev
   ```

4. 解决无法打开 clash-verge 的 tun 虚拟网卡模式

  - 可能是之前安装了旧版本的 clash-verge 导致服务配置指向的 clash-verge-service 路径错误， 编辑
   `/usr/lib/systemd/system/clash-verge-service.service` 中的可执行文件，一般指向 `/usr/bin/clash-verge-service`

  - 可能是没有相关 linux 能力导致的，执行如下命令可以修复

   ```bash
   sudo setcap cap_net_bind_service,cap_net_admin=+ep /usr/bin/clash-meta
   sudo setcap cap_net_bind_service,cap_net_admin=+ep /usr/bin/clash-verge
   ```

5. 解决 Chrome 在 wayland 会话下显示模糊的问题

   打开 Chrome, 地址栏输入 `chrome://flags` 进入 Chrome 的实验室功能，搜索 `Preferred Ozone platform` 选择 `Auto` 即可

6. GRUB 识别 window 系统

   略

7. GRUB 美化

   略

8. xwayland 应用在高分屏模糊问题

   原因是高分屏对 xwayland 只有在整数倍的缩放下才能够清晰，因此可以选择设置显示器整数倍缩放，但是这样字体会十分小，
   另一个解决方案是多显示器方案，xwayland 应用运行在普通分辨率的显示器上，并且该显示器的缩放设置为 1，这样会带来另
   一个问题，即鼠标位置偏移，具体现象是光标显示位置和实际位置部分，体感上表现为无相应，大多数 WM 都有这个问题，KDE
   可以正常使用。

9. xwayland 应用中 fcitx5 候选框大小异常

   编辑 `~/.Xresources` 文件，新增下列行，然后重启即可（或者使用 `xrdb -merge ~/.Xresources` 重新加载配置)

   ```.Xresources
   Xft.dpi=192
   ```

10. 非 KDE 环境中部分应用无法使用 xdg-desktop-portal 选取文件 file-picker

   原因是 wayland 环境的默认 xdg-desktop-portal 后端 xdg-desktop-portal-wlr 在这些环境中还不支持 file-picker，
   对于 gtk 的应用，需要额外安装并启用 gtk 的后端，具体命令如下：

   ```bash
   # 安装 gtk 的后端以支持选取文件
   sudo pacman -S xdg-desktop-portal-gtk
   # 重启主服务
   systemctl --user restart xdg-desktop-portal.service
   ```

11. 新版本的 clash-verge-rev 使用 polkit 进行认证，使用窗口管理器的用户如果需要静默授权需要使用增加如下规则到
    `/etc/polkit-1/rules.d/49-nopasswd-global.rules` 中，用户修改成登陆用户：

    ```javascript
    polkit.addRule(function(action, subject){
        if(subject.isInGroup("yunus")){
            return polkit.Result.YES;
        }
    })
    ```

