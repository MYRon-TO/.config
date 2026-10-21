{...}: {
  # Publish shared defaults without activating user environments as root.
  environment.etc."nixos-home/default.nix".source = ../home/default.nix;
  environment.etc."nixos-home/home.nix.example".source = ../home/home.nix.example;
}
