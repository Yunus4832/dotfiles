# dotfiles

ArchLinux 系统的配置文件仓库。

## 快速开始

```bash
git clone https://github.com/yunus/dotfiles.git ~/dotfiles
cd ~/dotfiles
./update.sh
```

`update.sh` 会将配置文件部署到对应位置。仅已安装对应软件时才会复制配置，未安装的软件包会安全跳过。

## 包含的配置

| 类别 | 软件 | 说明 |
|------|------|------|
| Shell | `zsh` | oh-my-zsh 配置 |
| 编辑器 | `vim` | 插件化配置 |
| 编辑器 | `zed` | 键位与编辑器配置 |
| 终端复用 | `tmux` | 终端会话管理 |
| 版本管理 | `git` | 全局 Git 配置 |
| WM | `river` | Wayland 动态平铺窗口管理器 |
| WM | `niri` | Wayland 卷轴式平铺窗口管理器 |
| 面板 | `waybar` | 状态栏 |
| 启动器 | `rofi` | 程序启动器 |
| 终端 | `foot` | 轻量终端模拟器 |
| 锁屏 | `swaylock` | 锁屏工具 |
| 空闲 | `swayidle` | 空闲管理器 |
| 代理 | `mihomo` | 网络代理 |
| 笔记 | `typora` | Markdown 编辑器主题 |
| 其他 | `xdg-desktop-portal` | 桌面门户配置 |

## 软件安装参考

[`archlinux-install.md`](archlinux-install.md) 记录了完整的软件包列表与配置注意事项。
