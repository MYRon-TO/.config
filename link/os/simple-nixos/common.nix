{ config, pkgs, lib, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  environment.systemPackages = with pkgs; [
    git curl wget vim zsh
    htop tmux tree
    unzip zip gnutar gzip xz
    file which gnugrep gnused gawk jq
    lsof strace pciutils usbutils
    inetutils iproute2 dnsutils
  ];

  environment.variables = {
    EDITOR = "vim";
    VISUAL = "vim";
  };

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  users.users.root.shell = pkgs.zsh;

  programs.nix-ld.enable = true;

  services.openssh.enable = true;
  programs.git.enable = true;

  time.timeZone = "Asia/Shanghai";
  networking.networkmanager.enable = lib.mkDefault true;

  system.stateVersion = "25.05";
}
