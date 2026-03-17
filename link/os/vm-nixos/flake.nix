{
  description = "Parameterized modular NixOS VM bootstrap on unstable";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }:
    let
      system = "x86_64-linux";
    in {
      nixosConfigurations.nixos-vm = nixpkgs.lib.nixosSystem {
        inherit system;

        specialArgs = {
          hostVars = import ./hosts/nixos-vm/variables.nix;
        };

        modules = [
          ./hosts/nixos-vm/default.nix
        ];
      };
    };
}
