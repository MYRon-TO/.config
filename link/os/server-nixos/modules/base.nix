{
  lib,
  pkgs,
  ...
}: {
  # This bootloader configuration assumes a UEFI installation.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "my-nix-server";
  networking.networkmanager.enable = true;
  networking.firewall.enable = true;

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
    publish = {
      enable = true;
      addresses = true;
    };
  };
  time.timeZone = lib.mkDefault "Asia/Shanghai";
  i18n.defaultLocale = "en_US.UTF-8";

  nix.settings.experimental-features = ["nix-command" "flakes"];
  nixpkgs.config.allowUnfree = true;
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  # Initial installation version; retain this value on future upgrades.
  system.stateVersion = "26.05";
}
