# dotfiles

Arch Linux 系统的配置文件仓库。仓库是配置的唯一来源：修改仓库中的文件，再部署到程序配置目录。部署后的手工修改是临时的，下次部署会被覆盖。

## 快速开始

```bash
git clone https://github.com/yunus/dotfiles.git ~/dotfiles
cd ~/dotfiles
./cctl list
./cctl vim apply
```

`cctl` 是配置管理脚本。配置部署仅支持 Arch Linux 及 Arch 系发行版。缺少某项依赖时，会显示包名及安装命令，并跳过该项。

## 命令

```bash
./cctl list                              # 列出配置项
./cctl apply foot                        # 部署指定的通用配置项
./cctl update foot                       # apply 的别名；仓库 → 配置目录
./cctl vim apply                         # 部署 Vim 的 .vimrc 和 .vim
./cctl apply --all                       # 安装基础软件包，再部署全部配置
./cctl apply base                        # 只安装基础包与 Oh My Zsh
./cctl add NAME SOURCE [TARGET] [PACKAGE...]
./cctl remove NAME                       # 从仓库移除配置项及其源文件，不删除已部署文件
./cctl push 'Update configurations'      # 提交并推送
./cctl pull                              # 拉取远端变更
./cctl compact                           # 压缩为一个提交并强制推送
```

## 安装命令与补全

```bash
./cctl install                            # 建立 ~/.local/bin/cctl 软链接
source <(cctl complete zsh)               # 在当前 zsh 会话启用补全
cctl uninstall                            # 删除安装的入口，保留配置仓库
```

也可用 `--system` 安装到 `/usr/local/bin`，或用 `install --copy` 放置指向当前仓库的启动器。目标已存在时需明确传入 `--force`；卸载只会自动移除指向当前仓库的入口。安装后仓库应保持在原路径；从任意目录运行时，`cctl` 会根据入口定位仓库。若 `~/.local/bin` 不在 `PATH` 中，需将它加入 shell 的 `PATH`。

`add` 按部署目标相对于 HOME 的位置组织仓库副本：`~/.config/foo` 对应 `.config/foo`，`~/.local/share/foo` 对应 `.local/share/foo`。直接位于 HOME 的文件，以及 HOME 之外的目标，放到以注册名称命名的目录；例如名称为 `mygit` 的 `~/.gitconfig` 存为 `mygit/.gitconfig`，`/etc/example.conf` 可存为 `example/example.conf`。目录会保留其子目录和隐藏文件。已有配置的注册信息位于 `.configctl/entries`，格式为 `名称|仓库路径|部署目标|逗号分隔的依赖包|部署钩子|sctl 补丁 ID`。基础软件包清单位于 `.configctl/packages/base`，可直接编辑。

例如，`cctl add myapp ~/.config/myapp/config.toml myapp` 注册单个文件；`cctl add widgets ~/.config/widgets widgets` 注册目录。省略 `TARGET` 时，使用 `SOURCE` 当前的绝对路径作为部署目标（HOME 下记为 `~/...`）。如果需要不同的目标，可显式填写绝对路径或以 `~/` 开头的路径。仓库内的源文件必须显式填写目标；仓库目标路径已存在时也会拒绝添加。`add` 只保存到仓库，不会立即部署；同名配置项会被拒绝。

`cctl vim apply` 会同时替换 `~/.vimrc` 和 `~/.vim`，并将 `.vimrc` 中的 `g:my_plug_dir` 指向仓库中的 `vim/vim-plug`。可用 `CONFIGCTL_VIM_PLUG_DIR` 覆盖插件目录路径。

`cctl apply base` 除了安装 `.configctl/packages/base` 中的软件包，还会在缺少 Oh My Zsh 时运行 `assets/oh-my-zsh-install.sh`。安装过程保留现有 `.zshrc`，也不会切换默认 shell；之后可用 `cctl apply zsh` 部署仓库的 `.zshrc`。

部署会替换目标文件或目录。如果目标目录里有 `*.patch`，或目标文件旁有同名的 `.patch`，会在覆盖后应用补丁；失败时恢复原配置。可选的 `sctl` ID 会调用 `sctl get` 解密补丁并应用。目录补丁可使用相对于配置目录的路径（如 `config`），也可带目录名前缀（如 `waybar/config`）；文件补丁使用文件名。

`pull` 发现远端历史被压缩时，会在重置前创建 `cctl-backup-*` 分支保存本地提交；要求工作区干净。`compact` 要求本地与远端提交一致，并用 `--force-with-lease` 推送改写后的历史。

## 包含的配置

| 类别 | 软件 | 说明 |
|------|------|------|
| Shell | `zsh` | oh-my-zsh 配置 |
| 编辑器 | `vim` | 插件化配置 |
| 编辑器 | `zed` | 键位与编辑器配置 |
| 终端复用 | `tmux` | 终端会话管理 |
| 版本管理 | `git` | 全局 Git 配置 |
| WM | `niri` | Wayland 卷轴式平铺窗口管理器 |
| 面板 | `waybar` | 状态栏 |
| 启动器 | `rofi` | 程序启动器 |
| 终端 | `foot` | 轻量终端模拟器 |
| 锁屏 | `swaylock` | 锁屏工具 |
| 空闲 | `swayidle` | 空闲管理器 |
| 代理 | `mihomo` | 网络代理 |
| 笔记 | `typora` | Markdown 编辑器主题 |
| 其他 | `xdg-desktop-portal` | 桌面门户配置 |
| 其他 | `user-dirs` | XDG 用户目录配置 |

## 软件安装参考

[`archlinux-install.md`](archlinux-install.md) 记录了完整的软件包列表与配置注意事项。
