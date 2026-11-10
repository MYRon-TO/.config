# Myron 的 Home Manager 配置

这是普通的 Standalone Home Manager 用户配置。仓库中的 `myron-home/` 只是暂存目录，使用时将整个目录移动到 `/home/myron/.config/home-manager/`。入口为 `home.nix`，不使用用户 flake 或自定义构建流程。

## 使用

先部署本仓库的 NixOS 系统配置，确保 Home Manager 命令和管理员维护的 `/etc/nixos-home/default.nix` 已安装。以 **myron 本人**执行，不使用 sudo。

如果目标目录已有配置，先备份；以下移动命令从包含 `myron-home/` 的目录运行：

```sh
mkdir -p ~/.config
test ! -e ~/.config/home-manager && mv myron-home ~/.config/home-manager
```

首次使用时配置与服务器一致的 26.05 channel：

```sh
nix-channel --add https://nixos.org/channels/nixos-26.05 nixpkgs
nix-channel --add https://github.com/nix-community/home-manager/archive/release-26.05.tar.gz home-manager
nix-channel --update
home-manager build
home-manager switch
```

Home Manager 默认读取 `~/.config/home-manager/home.nix`。`build` 仅构建，不激活。若已有 `.zshrc` 等文件冲突，先检查，再按需使用 `home-manager switch -b backup` 备份。激活后重新登录，之后可用 `hm-switch` 应用修改。

## 模块

- `home.nix`：常规 Home Manager 配置入口。
- `default.nix`：用户名 `myron`、家目录 `/home/myron`、`stateVersion = "26.05"`、个人 PATH 和模块导入。
- `shell.nix`：Zsh vi 模式、Oh My Zsh 的 git/history 插件、共享历史、Starship、zoxide、fzf 和常用别名。
- `utils.nix`：Yazi、lazygit、eza、bat、ouch、fastfetch、htop-vim、onefetch、socat、nmap、glow、Lua、rustup、uv 和 Typst。

`default.nix` 导入管理员发布的 `/etc/nixos-home/default.nix`，沿用 Vim、tmux、git 和极简 labwc 配置；这是服务器现有的共享默认配置机制，不引用仓库相邻目录。管理员更新默认值后，下次执行 Home Manager switch 时应用；个人模块可直接覆盖 `lib.mkDefault` 设置。

`y` 启动 Yazi，并在退出时切换到其所在目录。`lg` 启动 lazygit，`s` 启动 fastfetch。保留 Vim 为默认编辑器，没有强制设置 `TERM`、桌面类型或 SSH 会话变量。

未迁移 Homebrew、macOS Rime、Hyprland、固定蓝牙地址、Wine、Flutter 及依赖私人脚本的别名。不启用自动垃圾回收。SSH 中文输入和终端字体由客户端配置。

常用系统软件、Python、pnpm、字体及图形服务仍由 NixOS 管理。Rust 工具链需通过 `rustup default stable` 或项目配置选择；项目原生库依赖建议使用 devShell。

## 个性化与维护

在 `default.nix` 中添加真实 Git 身份，例如：

```nix
programs.git.settings.user = {
  name = "Myron";
  email = "你的邮箱";
};
```

更新用户依赖时执行 `nix-channel --update`，再运行 `home-manager build` 和 `home-manager switch`。用户 channel 不受系统 `flake.lock` 锁定。后续升级保留 `home.stateVersion = "26.05"`；通过 `home-manager generations` 查找旧代并执行其 `activate` 可回滚。
