# NixOS 多用户配置

面向全新安装，采用 **NixOS 26.05 + Standalone Home Manager 26.05**，以 SSH 访问为主。禁止 root SSH 登录和所有 SSH 密码登录；`myron` 通过密钥登录后可使用 sudo 管理系统，也可通过 `su -` 切换 root。

## 文件结构

```text
configuration.nix          模块入口和可选模块开关
flake.nix                  系统及 Home Manager 版本
hardware-configuration.nix  部署时提供目标机器的真实硬件配置
users.nix                  root、普通用户、公钥和附加组
modules/
  base.nix                 引导、主机名、网络、区域、Nix 和默认 shell
  packages.nix             系统软件和默认编辑器
  ssh.nix                  SSH 2222 和登录策略
  desktop.nix              labwc、greetd、音频、字体和移动硬盘服务
  home-manager.nix         发布共享 Home Manager 配置，不执行用户激活
optional/
  nvidia.nix               RTX 4070 Ti SUPER 驱动和 CUDA
home/
  default.nix              管理员维护的用户环境默认值
  home.nix.example         用户个人配置示例
```

主机名为 `my-nix-server`，默认 shell 为 zsh，默认编辑器为 Vim。系统软件包括 Firefox、git、curl、wget、cmake、pnpm 和常用开发、压缩、诊断工具。

桌面仅提供 labwc、kitty、wofi 和 Firefox，保留 PipeWire 音频。公共桌面软件安装在系统中，Home Manager 只维护个人配置和自动启动。无面板、壁纸程序、通知服务、图形文件管理器及自动锁屏；本地桌面无人使用时应退出会话。

UDisks2 提供挂载服务，桌面仅启动 polkit 授权代理和无托盘、无通知的 udiskie。自动挂载面向已登录的本地图形会话，SSH 会话不启动这些进程，也不会获得全局免授权挂载权限。可使用 `lsblk` 查看挂载点、`udisksctl unmount -b /dev/sdX1` 卸载指定分区；加密设备仍需解锁。

系统字体在 `modules/desktop.nix` 中配置，包含 Noto 中文与 Emoji、Material Design Icons、Font Awesome，以及 Nerd Fonts 的 Symbols Only、Fira Code、JetBrains Mono、Iosevka 和 Fantasque Sans Mono。字体安装在服务器上不会改变 SSH 客户端终端字体；客户端需要自行安装和选择字体。

## 1. root 部署系统

默认面向 **x86_64、UEFI**。ARM 需要修改 `flake.nix` 的 `system` 并移除当前 NVIDIA 模块；Legacy BIOS 需要按实际磁盘修改引导配置。现有系统应保留原有硬件、引导及 `stateVersion`。

本配置尚未部署，因此 `system.stateVersion`、共享 Home 默认值和个人示例统一设为 `26.05`。它们控制兼容行为，不是软件版本；本次新装完成后，后续升级应保留这些值。

将本目录复制到 `/etc/nixos`，保留该主机真实的 `hardware-configuration.nix`。在已安装的目标系统中，缺少硬件文件时可由 root 执行：

```sh
nixos-generate-config --show-hardware-config > /etc/nixos/hardware-configuration.nix
```

首次安装时先按 NixOS 手册分区并挂载到 `/mnt`，运行 `nixos-generate-config --root /mnt`，将模板复制到 `/mnt/etc/nixos`，保留生成的硬件文件，然后运行 `nixos-install --flake path:/mnt/etc/nixos#my-nix-server`。

### 账户与防止远程锁定

编辑 `users.nix`，确认 `myron` 的用户名和家目录，并填写真实 SSH 公钥。文件包含 `extraGroups`、shell、密码哈希文件和第二个普通用户的示例。

- root 是系统管理员，不配置 root SSH 公钥。
- `myron` 加入 `wheel` 和 `networkmanager`，可以使用 sudo 和管理网络。
- sudo 默认验证 **myron 自己的密码**，`su -` 验证 **root 密码**。
- 新增普通用户默认不加入 wheel；本地登录需要设置该用户自己的密码。
- `users.mutableUsers = true` 保留通过 `passwd` 设置的密码。
- 私钥、明文密码和密码哈希文件均不应放入仓库或 Nix store。

**切换前保留 root 会话或可用控制台。** 首次安装需在重启前设置 root 和 myron 的密码，并填写 myron 的 SSH 公钥。已运行的系统可通过 `sudo -i` 进入 root 后操作。

以下命令均在 root shell 中执行：

```sh
passwd root
cd /etc/nixos
nix --extra-experimental-features 'nix-command flakes' flake lock path:/etc/nixos
nixos-rebuild build --flake path:/etc/nixos#my-nix-server
nixos-rebuild switch --flake path:/etc/nixos#my-nix-server
passwd myron
```

首次安装时，在重启前设置用户密码：

```sh
nixos-enter --root /mnt -c 'passwd root'
nixos-enter --root /mnt -c 'passwd myron'
```

云安全组、上游防火墙需允许 TCP 2222。保留旧连接，从另一终端验证 SSH 和 sudo 成功后再退出：

```sh
ssh -p 2222 myron@my-nix-server
sudo -v
```

已启用 Avahi mDNS、主机地址发布及 UDP 5353 防火墙放行。同一局域网内支持 mDNS 的客户端可使用 `ssh -p 2222 myron@my-nix-server.local`；服务器也可解析 IPv4 `.local` 名称。mDNS 通常不跨子网，访客网络或无线客户端隔离可能阻止发现，失败时使用 IP 地址。已有的旧管理员账户、组成员和家目录需另行检查；本模板不会清理遗留用户数据。

提交并保留生成的 `flake.lock`，后续通过显式更新锁文件升级。命令使用 `path:`，避免未加入 Git 的文件被 flake 忽略。

## 2. 每个用户初始化 Home Manager

用户可以使用下面的通用示例创建自己的配置。

退出 root shell，以目标普通用户身份执行；不要以 root 身份为其他用户激活环境。系统使用 flake，用户 Home Manager 使用独立 channel，两者均选择 26.05。

```sh
nix-channel --add https://nixos.org/channels/nixos-26.05 nixpkgs
nix-channel --add https://github.com/nix-community/home-manager/archive/release-26.05.tar.gz home-manager
nix-channel --update
mkdir -p ~/.config/home-manager
cp /etc/nixos-home/home.nix.example ~/.config/home-manager/home.nix
vim ~/.config/home-manager/home.nix
home-manager build -f ~/.config/home-manager/home.nix
home-manager switch -f ~/.config/home-manager/home.nix
```

修改用户名、家目录和 Git 身份。已有用户保留自己的 `home.stateVersion`。用户 channel 不受系统 `flake.lock` 锁定；需要严格复现时应单独固定用户输入版本。

已有 `.zshrc`、`.vimrc` 或桌面配置冲突时先检查并备份。可用 `home-manager switch -b backup -f ~/.config/home-manager/home.nix` 备份冲突文件，不要直接删除原配置。

激活后重新登录桌面。`Super+Enter` 打开 kitty，`Super+D` 打开 wofi，`Super+Shift+Q` 退出桌面。当前不提供锁屏、空闲锁定或挂起前锁定；离开本地电脑前应退出会话。不要以 root 身份运行桌面。

## 3. 管理员默认值与用户覆盖

root 修改 `home/default.nix` 后重建系统，将其发布到 `/etc/nixos-home/default.nix`。用户配置导入该文件，不复制默认值；用户再次执行 Home Manager switch 才会应用更新。

标量和配置文件内容采用 `lib.mkDefault`，用户可直接覆盖：

```nix
programs.tmux.mouse = false;
programs.zsh.shellAliases.ll = "ls -lah";
programs.vim.extraConfig = ''
  set number relativenumber
'';
```

用户可通过 `home.packages` 添加个人软件。可覆盖 `xdg.configFile."labwc/autostart".text` 修改启动组件；需要自动挂载时应保留 polkit 和 udiskie。安装系统软件不会自动启动用户进程，新用户仍需激活 Home Manager 才能获得本配置的快捷键及自动挂载。

默认值不是强制安全策略，用户可以移除 import。系统软件由 `modules/packages.nix` 管理，用户不能通过 Home Manager 卸载系统软件。

## 4. 可选 NVIDIA / CUDA 模块

`configuration.nix` 默认导入 `./optional/nvidia.nix`，面向 **RTX 4070 Ti SUPER、单 NVIDIA 桌面显卡、Wayland**：

- 使用当前内核对应的稳定版 NVIDIA 驱动和开放内核模块；用户态驱动仍包含非自由组件。
- 启用 DRM modesetting，供 labwc/Wayland 使用。`services.xserver.videoDrivers` 用于集成驱动，不会单独启用 X11 桌面。
- 启用挂起时显存保存；临时存储需要容纳显存内容，需在实际机器上验证挂起恢复。
- 安装 `cudaPackages.cudatoolkit`，提供 `nvcc`；不全局启用 `cudaSupport`，避免所有相关软件触发 CUDA 重建。
- 不添加过时的全局 wlroots/NVIDIA 环境变量，不配置笔记本混合显卡 PRIME。

切换驱动后重启，验证：

```sh
nvidia-smi
nvcc --version
echo "$XDG_SESSION_TYPE $WAYLAND_DISPLAY"
```

`nvidia-smi` 显示的是驱动支持的 CUDA 版本上限，`nvcc --version` 显示实际工具链版本。4070 Ti SUPER 的计算能力为 8.9，项目编译时可按需指定 `-arch=sm_89`。CUDA 工具链体积较大；项目应通过独立 devShell 配置兼容的宿主编译器、库路径及 cuDNN 等依赖，安装 toolkit 不会自动让任意 pip wheel 或外部二进制兼容 NixOS。还需实际运行项目的 GPU 测试。

在无 NVIDIA 显卡的电脑上，删除或注释 `configuration.nix` 中该模块的 import，重建并重启即可。旧系统代仍会保留驱动和 CUDA 闭包以供回滚；确认新系统正常后再按需清理旧代。不需要删除 Home Manager 的 labwc 配置。其他可选硬件模块也可放入 `optional/`，目录不会自动导入。

## 5. 验证与回滚

部署前运行系统和用户的 build。部署后检查 SSH、sudo、kitty、wofi、自动挂载、音频、第二个用户的独立环境，以及 NVIDIA/CUDA 和挂起恢复。

```sh
hostname
systemctl status sshd greetd udisks2
ss -lnt | rg ':2222'
```

系统回滚由 root 执行 `nixos-rebuild switch --rollback`，或从引导菜单选择旧代。用户通过 `home-manager generations` 查找旧代并运行其 `activate`。

已生成 `flake.lock`。系统配置在临时的求值用根分区和 EFI 分区声明下成功求值，Home Manager 示例在将共享模块路径替换为仓库路径后也成功求值；这些测试配置没有写入部署文件。尚未构建系统或验证真实硬件，部署前仍需生成目标机器的 `hardware-configuration.nix` 并执行 build。
