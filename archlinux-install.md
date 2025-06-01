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
git -- 版本管理工具
fzf -- 模糊搜索工具
curl -- 终端 http 客户端
ctags -- 用于生成 tags 文件
astyle -- 格式化代码
jq -- json 格式化工具
ranger -- 文件管理器
vifm -- 另一个简单的文件管理器
bat -- cat 的上位替代
zsh -- 更好用的 shell
tmux -- 终端复用工具
dtash -- 另一个更轻量级的终端复用工具
dvtm -- 另一个轻量级的终端平铺窗口工具

sway -- 窗口管理器
swaybg -- 窗口管理器背景图
swaylock | swaylock-effects -- 窗口管理器锁屏 | 带特殊效果
swayimg -- 查看图片
flatpak -- 软件沙盒环境
foot -- 终端模拟器

wl-clipboard -- wayland 协议的剪切板

fcitx5 -- 输入法
fcitx5-chinese-addons -- 输入法中文扩展
fcitx5-cn-meta
fcitx5-qt
fcitx5-gtk
fcitx5-material-color

python -- 通用脚本语言
nodejs -- node 环境，用于运行语言服务器
```

## 其他注意事项

1. Java GUI 程序对于 Wayland 环境需要设置特殊的环境变量运行

   ```bash
   sudo flatpak override --env=GTK_IM_MODULE=fcitx --env=QT_IM_MODULE=fcitx --env=XMODIFIERS=@im=fcitx
   ```

