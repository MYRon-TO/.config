{ pkgs, ... }:
{
  # 密码由 root 使用 passwd 管理，重建系统时不重置。
  users.mutableUsers = true;
  security.sudo.enable = true;

  users.users = {
    root = {
      shell = pkgs.zsh;
      # 部署时执行 passwd root 设置密码。不要在仓库中保存明文密码。
      # SSH 模块禁止 root 登录，因此不在这里配置 root SSH 公钥。
    };

    # 填写真实公钥后再部署。wheel 允许使用需要密码的 sudo。
    myron = {
      isNormalUser = true;
      description = "Myron";
      home = "/home/myron";
      createHome = true;
      shell = pkgs.zsh;
      extraGroups = [ "networkmanager" "wheel"];
      openssh.authorizedKeys.keys = [
        # "ssh-ed25519 AAAA... myron@laptop"
      ];

      # 本地登录和 sudo 需要密码，由 root 执行 passwd myron 设置。
      # 如需声明式管理密码，可配置仓库之外、仅 root 可读的哈希文件。
      # 文件必须在系统激活前存在，内容为 mkpasswd -m yescrypt 生成的哈希。
      # hashedPasswordFile = "/var/lib/nixos-secrets/myron-password-hash";
    };

    # 新增用户时取消注释，并填写实际信息。
    # bob = {
    #   isNormalUser = true;
    #   description = "Bob";
    #   home = "/home/bob";
    #   createHome = true;
    #   shell = pkgs.zsh;
    #   extraGroups = [ ];
    #   openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAA... bob@laptop" ];
    # };
  };

  # 自定义协作组需要显式声明，并加入相关用户的 extraGroups。
  # users.groups.developers = { };
}
