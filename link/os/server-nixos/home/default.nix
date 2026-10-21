{
  lib,
  pkgs,
  ...
}: {
  home.stateVersion = lib.mkDefault "26.05";
  home.sessionVariables = {
    EDITOR = lib.mkDefault "vim";
    VISUAL = lib.mkDefault "vim";
    MOZ_ENABLE_WAYLAND = lib.mkDefault "1";
  };

  programs.zsh = {
    enable = lib.mkDefault true;
    enableCompletion = lib.mkDefault true;
    autosuggestion.enable = lib.mkDefault true;
    syntaxHighlighting.enable = lib.mkDefault true;
    shellAliases = {
      ll = lib.mkDefault "ls -lah";
      hm-switch = lib.mkDefault "home-manager switch -f ~/.config/home-manager/home.nix";
    };
  };
  programs.git.enable = lib.mkDefault true;
  programs.tmux = {
    enable = lib.mkDefault true;
    mouse = lib.mkDefault true;
    terminal = lib.mkDefault "tmux-256color";
  };
  programs.vim = {
    enable = lib.mkDefault true;
    defaultEditor = lib.mkDefault true;
    extraConfig = lib.mkDefault ''
      set number
      set expandtab shiftwidth=2 tabstop=2
      set ignorecase smartcase
      set undofile
    '';
  };
  xdg.enable = lib.mkDefault true;

  # Absolute paths keep session startup independent of shell initialization.
  xdg.configFile."labwc/autostart" = {
    executable = true;
    text = lib.mkDefault ''
      #!/bin/sh
      ${pkgs.dbus}/bin/dbus-update-activation-environment --systemd WAYLAND_DISPLAY DISPLAY XDG_CURRENT_DESKTOP
      ${pkgs.lxqt.lxqt-policykit}/bin/lxqt-policykit-agent &
      ${pkgs.udiskie}/bin/udiskie --automount --no-notify --no-tray &
    '';
  };
  xdg.configFile."labwc/rc.xml".text = lib.mkDefault ''
    <?xml version="1.0"?>
    <labwc_config>
      <keyboard>
        <default />
        <keybind key="W-Return"><action name="Execute" command="${pkgs.kitty}/bin/kitty" /></keybind>
        <keybind key="W-d"><action name="Execute" command="${pkgs.wofi}/bin/wofi --show drun" /></keybind>
        <keybind key="W-S-q"><action name="Exit" /></keybind>
      </keyboard>
      <mouse><default /></mouse>
    </labwc_config>
  '';
}
