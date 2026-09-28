# cctl Hook 编写协议

每个配置项可注册一个前置 hook 和一个后置 hook。`restore` 脚本是独立操作，不运行配置项 hook。

## 注册

```bash
cctl hook NAME pre ./prepare.sh
cctl hook NAME post ./finish.sh
cctl hook NAME post --remove
```

注册时，`cctl` 把脚本复制到仓库的 `.cctl/hooks/NAME-pre.sh` 或 `NAME-post.sh`，并将仓库相对路径写入 `.cctl/entries`。`--remove` 只取消注册，不删除脚本文件。修改已注册的脚本后，需要在仓库提交修改，才能同步到其他机器。

## 执行约定

- 使用 Bash 运行脚本，无需设置可执行位；工作目录固定为仓库根目录。
- 参数依次为 `$1` 配置名称、`$2` 仓库源文件或目录的绝对路径、`$3` 部署目标的绝对路径。路径可能包含空格，使用时应加引号。
- 继承调用 `cctl` 的环境变量、标准输出和标准错误。返回 `0` 表示成功，非零表示失败；`cctl apply` 随之返回非零，并停止该配置项的后续步骤。
- 每次 `apply NAME` 都会运行已注册的 hook，包括重复部署。脚本应能安全地重复运行。

单个配置项的顺序为：检查源文件、hook 和软件包依赖 → 创建目标父目录 → 前置 hook → 复制仓库文件 → 应用目标旁的 `*.patch` → 应用可选的 `sctl` 补丁 → 后置 hook。前置 hook 执行时，目标可能尚不存在；后置 hook 执行时，补丁已经应用。

对于单个文件，复制或后置 hook 失败时，`cctl` 会恢复原目标文件。对于目录，复制和 hook 的副作用不会自动回滚；任何前置 hook 的副作用也不会自动回滚。hook 应只处理所属配置的额外步骤，补丁由通用 `apply` 流程处理。

## 示例

后置 hook 根据部署的压缩包生成一个目录：

```bash
#!/usr/bin/env bash
set -euo pipefail

dest=$3
if [ ! -f "$dest/ui/index.html" ]; then
    mkdir -p -- "$dest/ui"
    tar -xzf "$dest/ui.tar.gz" -C "$dest/ui"
fi
```

实际脚本可参考 [Mihomo 后置 hook](../.cctl/hooks/mihomo-post.sh)、[Vim 前置 hook](../.cctl/hooks/vim-pre.sh) 和 [Vim 后置 hook](../.cctl/hooks/vim-post.sh)。
