# dotfiles

配置文件仓库。仓库是配置的唯一来源：修改仓库中的文件，再部署到程序配置目录。部署后的手工修改是临时的，下次部署会被覆盖。

## 快速开始

```bash
git clone https://github.com/yunus/dotfiles.git ~/dotfiles
cd ~/dotfiles
./bin/cctl ls
./bin/cctl apply vim
```

`cctl` 是配置管理脚本。配置部署可在不同发行版上运行。系统有 pacman 时，会检查配置项的依赖包；缺少依赖时显示包名及安装命令，并跳过该项。没有 pacman 时不检查这些包名。

## 命令

```bash
./bin/cctl ls                                # 列出配置项
./bin/cctl apply foot                        # 部署指定的通用配置项
./bin/cctl update foot                       # apply 的别名；仓库 → 配置目录
./bin/cctl apply vim                         # 部署 Vim 的 .vimrc 和 .vim
./bin/cctl apply --all                       # 部署全部注册的配置项
./bin/cctl restore archlinux                 # Arch 系用 pacman/paru 安装基础软件包
./bin/cctl restore oh-my-zsh                 # 使用仓库附带脚本安装 Oh My Zsh
./bin/cctl add NAME SOURCE [TARGET] [PACKAGE...]
./bin/cctl hook NAME pre|post SCRIPT         # 注册应用前或应用后的脚本
./bin/cctl hook NAME pre|post --remove       # 取消对应的 hook
./bin/cctl remove NAME                       # 从仓库移除配置项及其源文件，不删除已部署文件
./bin/cctl push 'Update configurations'      # 提交并推送
./bin/cctl pull                              # 拉取远端变更
./bin/cctl compact                           # 压缩为一个提交并强制推送
```

## 安装命令与补全

```bash
./bin/cctl install                            # 建立 ~/.local/bin/cctl 软链接
source <(cctl cmp zsh)                    # 在当前 zsh 会话启用补全
cctl uninstall                            # 删除安装的入口，保留配置仓库
```

也可用 `--system` 安装到 `/usr/local/bin`，或用 `install --copy` 放置指向当前仓库的启动器。安装会替换目标位置已有的入口；卸载只会自动移除指向当前仓库的入口。安装后仓库应保持在原路径；从任意目录运行时，`cctl` 会根据入口定位仓库。若 `~/.local/bin` 不在 `PATH` 中，需将它加入 shell 的 `PATH`。

`add` 按部署目标相对于 HOME 的位置组织仓库副本：`~/.config/foo` 对应 `.config/foo`，`~/.local/share/foo` 对应 `.local/share/foo`。直接位于 HOME 的文件，以及 HOME 之外的目标，放到以注册名称命名的目录；例如名称为 `mygit` 的 `~/.gitconfig` 存为 `mygit/.gitconfig`，`/etc/example.conf` 可存为 `example/example.conf`。目录会保留其子目录和隐藏文件。已有配置的注册信息位于 `.cctl/entries`，格式为 `名称|仓库路径|部署目标|逗号分隔的依赖包|前置 hook|后置 hook|sctl 补丁 ID`。

例如，`cctl add myapp ~/.config/myapp/config.toml myapp` 注册单个文件；`cctl add widgets ~/.config/widgets widgets` 注册目录。省略 `TARGET` 时，使用 `SOURCE` 当前的绝对路径作为部署目标（HOME 下记为 `~/...`）。如果需要不同的目标，可显式填写绝对路径或以 `~/` 开头的路径。仓库内的源文件必须显式填写目标；仓库目标路径已存在时也会拒绝添加。`add` 只保存到仓库，不会立即部署；同名配置项会被拒绝。

`cctl hook` 将脚本复制到 `.cctl/hooks/` 并注册到配置项。脚本的参数、执行顺序、失败行为和示例见 [Hook 编写协议](docs/hooks.md)。`cctl apply vim` 的前置 hook 将 `.vim` 目录复制到 HOME，通用流程部署并应用 `.vimrc.patch`，后置 hook 将 `g:my_plug_dir` 指向仓库中的 `vim/vim-plug`。可用 `CONFIGCTL_VIM_PLUG_DIR` 覆盖插件目录路径。

`restore` 与配置部署分离，只运行 `.cctl/restore/` 下对应的脚本，并使用 `asset/同名目录/` 中的资产；发行版判断由脚本自行完成，新增脚本的约定见 [Restore 脚本协议](docs/restore.md)。`cctl restore archlinux` 仅支持 Arch Linux 及 Arch 系发行版，使用 pacman 或 paru 安装 `asset/archlinux/packages` 中的软件包。将来可通过独立脚本增加 Debian 等发行版的还原操作。`cctl restore oh-my-zsh` 不依赖发行版，缺少 Oh My Zsh 时运行 `asset/oh-my-zsh/oh-my-zsh-install.sh`；安装时保留现有 `.zshrc`，也不会切换默认 shell。之后可用 `cctl apply zsh` 部署仓库的 `.zshrc`。

目录配置部署会覆盖仓库管理的文件，保留目标目录中的其他文件，包括 `*.patch`；复制后应用补丁。单个文件配置会替换目标文件，失败时恢复原文件。可选的 `sctl` ID 会调用 `sctl get` 解密补丁并应用。目录补丁可使用相对于配置目录的路径（如 `config`），也可带目录名前缀（如 `waybar/config`）；文件补丁使用文件名。

`mihomo` 的后置 hook 只在目标目录缺少 `ui/index.html` 时从 `ui.tar.gz` 解压；已有 UI 会保留，避免覆盖其运行时文件。

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
