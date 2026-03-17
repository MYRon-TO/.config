{ config, pkgs, lib, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  environment.systemPackages = with pkgs; [
    git curl wget vim zsh
    htop tmux tree
    unzip zip gnutar gzip xz
    file which fd ripgrep
  ];

  environment.variables = {
    EDITOR = "vim";
    VISUAL = "vim";
  };

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  programs.nix-ld.enable = true;

  services.openssh.enable = true;
  programs.git.enable = true;

  time.timeZone = "Asia/Shanghai";
  networking.networkmanager.enable = lib.mkDefault true;
}
