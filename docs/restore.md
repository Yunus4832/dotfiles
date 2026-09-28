# cctl Restore 脚本协议

`cctl restore NAME` 查找 `.cctl/restore/NAME.sh` 和 `asset/NAME/`，只运行对应的脚本。它不读取配置项注册表，不复制配置文件，也不执行 apply hook。`cctl apply --all` 不运行 restore 脚本。

脚本由 Bash 启动，`$1` 是仓库根目录的绝对路径，`$2` 是 `asset/NAME/` 的绝对路径。脚本继承调用者的环境、标准输出和标准错误；返回非零状态表示还原失败。名称只能包含字母、数字、点、下划线和连字符，且必须以字母或数字开头。

新增操作时，创建 `.cctl/restore/NAME.sh`，并把它用到的清单、安装脚本等文件放进 `asset/NAME/`。脚本自行判断适用的发行版和所需命令；`cctl restore` 入口不判断发行版。建议脚本使用 `set -euo pipefail`，并在重复执行时安全地跳过已经完成的步骤。`archlinux.sh` 读取 `asset/archlinux/packages`；将来可增加 `debian.sh` 和 `asset/debian/`。`oh-my-zsh.sh` 调用 `asset/oh-my-zsh/oh-my-zsh-install.sh`。
