{
  description = "NixOS config for macOS using nix-darwin";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    # nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin";

    # home-manager, used for managing user configuration
    home-manager = {
      url = "github:nix-community/home-manager/master";
      # inputs.nixpkgs.follows = "nixpkgs-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nix-darwin,
    nixpkgs,
    home-manager,
    ...
  }: let
    system = "aarch64-darwin";
    hostname = "TOS-MAC";
    username = "miaoyuanrong";

    specialArgs =
      inputs
      // {
        inherit username hostname;
        gitCommitHash = self.rev or self.dirtyRev or null;
      };

    configuration = {pkgs, ...}: {
      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "${system}";
    };

  in {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#TOS-MAC
    darwinConfigurations."${hostname}" = nix-darwin.lib.darwinSystem {
      inherit system specialArgs;
      modules = [
        ./modules/system.nix
        ./modules/core.nix
        ./modules/host_users.nix
        ./modules/apps.nix
        ./modules/brew-mirror.nix

        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = specialArgs;
          home-manager.users.${username} = import ./home;
        }
      ];
    };
  };
}
