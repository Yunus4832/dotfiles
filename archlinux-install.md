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

