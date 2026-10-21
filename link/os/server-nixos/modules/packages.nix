{
  pkgs,
  home-manager,
  ...
}: {
  programs.vim = {
    enable = true;
    defaultEditor = true;
  };
  programs.firefox.enable = true;
  environment.variables = {
    EDITOR = "vim";
    VISUAL = "vim";
  };
  environment.systemPackages = with pkgs; [
    home-manager.packages.${pkgs.stdenv.hostPlatform.system}.home-manager

    # Minimal shared desktop tools; user configuration lives in Home Manager.
    kitty
    wofi
    udiskie
    lxqt.lxqt-policykit

    git
    curl
    wget
    cmake
    ninja
    gnumake
    gcc
    pkg-config
    nodejs
    pnpm
    python3
    fd
    ripgrep
    tmux
    file
    which
    tree
    zip
    xz
    unzip
    p7zip
    rar
    jq
    yq-go
    htop
    btop
    rsync
    lsof
    pciutils
    usbutils
    dnsutils
    openssl
    gnupg
    nixfmt
  ];
}
