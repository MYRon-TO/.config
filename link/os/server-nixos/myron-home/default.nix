{ config, ... }:
{
  imports = [
    /etc/nixos-home/default.nix
    ./shell.nix
    ./utils.nix
  ];

  home = {
    username = "myron";
    homeDirectory = "/home/myron";
    stateVersion = "26.05";
    sessionVariables.PNPM_HOME = "${config.home.homeDirectory}/.local/share/pnpm";
    sessionPath = [
      "${config.home.homeDirectory}/bin"
      "${config.home.homeDirectory}/.local/bin"
      "${config.home.homeDirectory}/.config/scripts"
      "${config.home.homeDirectory}/.cargo/bin"
      "${config.home.homeDirectory}/go/bin"
      "${config.home.homeDirectory}/.local/share/pnpm"
    ];
  };

  programs.home-manager.enable = true;
}
