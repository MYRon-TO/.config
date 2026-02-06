{
  config,
  pkgs,
  ...
}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    plugins = [
      {
        name = "zsh-vi-mode";
        src = pkgs.zsh-vi-mode;
        file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
      }
    ];

    oh-my-zsh = {
      enable = true;
      plugins = ["git" "web-search" "history"];
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
      s = "neofetch";
      lg = "lazygit";
      py = "python3";
      ll = "ls -al";
      split_wallpaper = "python ~/.script/split_wallpaper.py";
      earphone = "bluetoothctl connect 88:C9:E8:BA:C1:8C";
      keyboard = "bluetoothctl connect F1:EF:01:DE:A7:D6";
      doom = "~/.config/emacs/bin/doom";
      lzd = "lazydocker";
      HP = "Hyprland";
    };

    sessionVariables = {
      EDITOR = "nvim";

      # Flutter
      PUB_HOSTED_URL = "https://mirrors.tuna.tsinghua.edu.cn/dart-pub";
      FLUTTER_STORAGE_BASE_URL = "https://mirrors.tuna.tsinghua.edu.cn/flutter";

      # DarkMode
      GTK_THEME = "Adwaita:dark";
      GTK2_RC_FILES = "/usr/share/themes/Adwaita-dark/gtk-2.0/gtkrc";
      QT_STYLE_OVERRIDE = "Adwaita-Dark";

      # Fcitx5
      QT_IM_MODULE = "fcitx";
      SDL_IM_MODULE = "fcitx";
      QT_WAYLAND_TEXT_INPUT_PROTOCOL = "zwp_text_input_v3";
      XDG_CURRENT_DESKTOP = "Hyprland";
      XDG_SESSION_TYPE = "wayland";

      # Kitty
      GLFW_IM_MODULE = "ibus";
      TERM = "xterm-256color";

      # TeX
      TEXMFHOME = "$HOME/.local/share/texmf";

      # Go
      GO111MODULE = "on";
      GOPROXY = "https://mirrors.aliyun.com/goproxy/,direct";

      # Rust
      RUSTUP_DIST_SERVER = "";
      RUSTUP_UPDATE_ROOT = "";

      # HuggingFace
      HF_ENDPOINT = "https://huggingface.co";

      # PNPM
      PNPM_HOME = "${config.home.homeDirectory}/.local/share/pnpm";
    };

    initExtra = ''

      if [ -f /opt/homebrew/bin/brew ]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
      fi

      # Path configurations
      export PATH=$HOME/bin:$HOME/.config/scripts:/usr/local/bin:$HOME/.cargo/bin:$HOME/go/bin:$HOME/.local/bin:$PATH
      export PATH=$HOME/.cabal/bin:$HOME/.ghcup/bin:$PATH
      export PATH=$HOME/Git/dev_bin:$PATH
      export PATH=/usr/local/texlive/2024/bin/x86_64-linux:$PATH

      # PNPM Path
      case ":$PATH:" in
        *":$PNPM_HOME:"*) ;;
        *) export PATH="$PNPM_HOME:$PATH" ;;
      esac

      # Conda
      # [ -f /opt/miniforge/etc/profile.d/conda.sh ] && source /opt/miniforge/etc/profile.d/conda.sh

      # Yazi function
      function y() {
        local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
        yazi "$@" --cwd-file="$tmp"
        if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
          builtin cd -- "$cwd"
        fi
        rm -f -- "$tmp"
      }
    '';
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
    defaultOptions = [
      "--preview 'bat --style=numbers --color=always --line-range :500 {}'"
      "--color=fg:#cdd6f4,fg+:#d0d0d0,bg:#1e1e2e,bg+:#262626"
      "--color=hl:#f38ba8,hl+:#5fd7ff,info:#cba6f7,marker:#b4befe"
      "--color=prompt:#cba6f7,spinner:#f5e0dc,pointer:#f5e0dc,header:#f38ba8"
      "--color=border:#262626,label:#aeaeae,query:#d9d9d9"
      "--border='rounded' --border-label='' --preview-window='border-rounded' --prompt='⪢ '"
      "--marker='> ' --pointer='⪢ ' --separator='-' --scrollbar='│'"
      "--info='right'"
    ];
  };
}
