{ hostVars, ... }:

{
  imports = [
    ../../hardware-configuration.nix
    ../../modules/base.nix
    ../../modules/nix-core.nix
    ../../modules/dev-tools.nix
    ../../modules/services.nix
    ../../modules/users.nix
  ];

  networking.hostName = hostVars.hostName;
  system.stateVersion = hostVars.systemStateVersion;
}
