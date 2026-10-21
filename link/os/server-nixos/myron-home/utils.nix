{ pkgs, ... }:
{
  # Common tools such as git, tmux, Python and archive utilities come from NixOS.
  home.packages = with pkgs; [
    ouch
    fastfetch
    htop-vim
    onefetch
    socat
    nmap
    glow
    lua
    rustup
    uv
    typst
  ];

  programs.bat.enable = true;
  programs.lazygit.enable = true;
  programs.eza = {
    enable = true;
    git = true;
    icons = "auto";
    enableZshIntegration = true;
  };
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    shellWrapperName = "y";
    settings.mgr = {
      show_hidden = true;
      sort_dir_first = true;
    };
  };
}
