{pkgs, ...}: {
  home.packages = with pkgs; [
    # archives
    zip
    xz
    unzip
    p7zip

    # utils
    ripgrep # recursively searches directories for a regex pattern
    jq # A lightweight and flexible command-line JSON processor
    fzf # A command-line fuzzy finder

    tmux
    neofetch # A command-line system information tool
    htop-vim
    onefetch # A command-line Git repository summary tool

    yazi
    lazygit

    socat # replacement of openbsd-netcat
    nmap # A utility for network discovery and security auditing

    # misc
    file
    which
    tree

    # productivity
    glow # markdown previewer in terminal

    # develop
    lua
    rustup
    uv

    # doc
    typst
  ];

  programs = {
    # A modern replacement for ‘ls’
    # useful in bash/zsh prompt, not in nushell.
    eza = {
      enable = true;
      git = true;
      icons = "auto";
      enableZshIntegration = true;
    };

    # # terminal file manager
    # yazi = {
    #   enable = true;
    #   enableZshIntegration = true;
    #   settings = {
    #     manager = {
    #       show_hidden = true;
    #       sort_dir_first = true;
    #     };
    #   };
    # };

    # skim provides a single executable: sk.
    # Basically anywhere you would want to use grep, try sk instead.
    skim = {
      enable = true;
      enableBashIntegration = true;
    };
  };
}
