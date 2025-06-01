# 我的 Linux 系统配置仓库

我使用 Archlinux, `archlinux-install.sh` 描述我安装和使用的哪些软件，以下是我常用的软件的配置文件清单，
使用 `update.sh` 可以快速更新和同步不同机器上的软件配置。 软件配置列表如下。

| 软件名称 | 配置文件名称     | 类型   | 存储路径               | 输出路径           | 描述                                |
|----------|------------------|--------|------------------------|--------------------|-------------------------------------|
| vim      | .vimrc           | 文件   | vim/.vimrc             | ~/.vimrc           | vim 主配置文件                      |
|          | .vim             | 文件夹 | vim/.vim               | ~/.vim             | 用户自定义资源 plug.vim 存储在这里  |
|          | .vimrc9          | 文件   | vim/.vimrc9            | ~/.vimrc9          | vim9 特有的配置，为了兼容低版本 Vim |
| tmux     | .tmux.conf       | 文件   | tmux/.tmux.conf        | ~/.tmux.conf       | tmux 主配置                         |
|          | .tmux.conf.local | 文件   | tmux/.tmux.confg.local | ~/.tmux.conf.local | 用户自定义的 tmux 配置              |
| zsh      | .zshrc           | 文件   | zsh/.zshrc             | ~/.zshrc           | zsh 主配置文件                      |
| ideavim  | .ideavimrc       | 文件   | ideavim/.ideavimrc     | ~/.ideavimrc       | JetBrain Ideavim 插件配置           |
| sway     | sway             | 文件夹 | .config/sway           | ~/.config/sway     | sway 窗口管理器配置                 |
| swayimg  | swayimg          | 文件夹 | .config/swayimg        | ~/.config/swayimg  | swayimg 图像查看配置                |
| foot     | foot             | 文件夹 | .config/foot           | ~/.config/foot     | foot 终端模拟器配置                 |
| swaylock | swaylock         | 文件夹 | .config/swaylock       | ~/.config/swaylock | sway 的锁屏配置                     |
| waybar   | waybar           | 文件夹 | .config/waybar         | ~/.config/waybar   | sway 状态栏配置                     |

