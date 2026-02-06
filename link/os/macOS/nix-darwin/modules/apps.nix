{pkgs, ...}: {
  nixpkgs.config.allowUnfree = true; # Allow unfree packages;

  # Install packages from nix's official package repository.
  #
  # The packages installed here are available to all users, and are reproducible across machines, and are rollbackable.
  # But on macOS, it's less stable than homebrew.
  #
  # Related Discussion: https://discourse.nixos.org/t/darwin-again/29331
  environment.systemPackages = with pkgs; [
    git
    neovim
  ];
  environment.variables.EDITOR = "nvim";

  # The apps installed by homebrew are not managed by nix, and not reproducible!
  # But on macOS, homebrew has a much larger selection of apps than nixpkgs, especially for GUI apps!
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true;
      upgrade = true;
      # 'zap': uninstalls all formulae(and related files) not listed here.
      cleanup = "zap";
    };

    masApps = {
      Xcode = 497799835;
      # Wechat = 836500024;
      # QQ = 451108668;
    };

    taps = [
      "homebrew/services"
      "daipeihust/tap"
    ];

    # `brew install`
    brews = [
      # auto switch input method on macOS
      "im-select"

      "wget"
      "curl"
    ];

    # `brew install --cask`
    casks = [
      "google-chrome"
      "zen"

      "qbittorrent"
      "iina"

      "kitty"
    ];
  };
}
