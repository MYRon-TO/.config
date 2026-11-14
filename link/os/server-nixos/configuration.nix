{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./modules/base.nix
    ./modules/packages.nix
    ./modules/ssh.nix
    ./modules/desktop.nix
    ./modules/home-manager.nix
    ./users.nix

    # Remove this import on machines without an NVIDIA GPU.
    ./optional/nvidia.nix
  ];
}
