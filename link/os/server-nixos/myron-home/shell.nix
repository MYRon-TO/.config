{ config, pkgs, ... }:
{
  programs.zsh = {
    plugins = [
      {
        name = "zsh-vi-mode";
        src = pkgs.zsh-vi-mode;
        file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
      }
    ];
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "history" ];
    };
    history = {
      size = 10000000;
      save = 10000000;
      path = "${config.home.homeDirectory}/.zsh_history";
      ignoreDups = true;
      share = true;
      ignoreSpace = true;
    };
    shellAliases = {
      q = "exit";
      s = "fastfetch";
      lg = "lazygit";
      py = "python3";
      ll = "eza -al";
      hm-switch = "home-manager switch";
    };
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    # Only preview file selections; history entries are not filesystem paths.
    fileWidgetOptions = [
      "--preview 'bat --style=numbers --color=always --line-range :500 -- {}'"
    ];
  };
}
