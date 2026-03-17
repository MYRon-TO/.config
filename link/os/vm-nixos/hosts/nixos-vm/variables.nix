{
  hostName = "nixos-vm";
  timeZone = "Asia/Shanghai";
  defaultLocale = "zh_CN.UTF-8";
  consoleKeyMap = "us";

  user = {
    name = "youruser";
    description = "Default admin user";
    extraGroups = [ "wheel" "networkmanager" ];
    sshKeys = [];
  };

  openssh = {
    enable = true;
    passwordAuthentication = false;
    permitRootLogin = "no";
  };

  qemuGuestEnable = true;
  spiceAgentEnable = true;
  allowUnfree = true;
  systemStateVersion = "25.11";

  editor = "vim";

  devPackages = [
    "git"
    "curl"
    "wget"
    "vim"
    "htop"
    "tree"
    "unzip"
    "zip"
    "gnutar"
    "gzip"
    "jq"
    "ripgrep"
    "fd"
    "gcc"
    "gnumake"
    "cmake"
    "pkg-config"
    "python3"
    "nixfmt-rfc-style"
  ];
}
