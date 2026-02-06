{
  pkgs,
  gitCommitHash,
  ...
}:
###################################################################################
#
#  macOS's System configuration
#
#  All the configuration options are documented here:
#    https://daiderd.com/nix-darwin/manual/index.html#sec-options
#
###################################################################################
{
  system = {
    stateVersion = 6;
    # Set Git commit hash for darwin-version.
    configurationRevision = gitCommitHash;

    defaults = {
      menuExtraClock.Show24Hour = true; # show 24 hour clock

      # customize finder
      finder = {
        _FXShowPosixPathInTitle = true; # show full path in finder title
        AppleShowAllExtensions = true; # show all file extensions
        FXEnableExtensionChangeWarning = false; # disable warning when changing file extension
        QuitMenuItem = true; # enable quit menu item
        ShowPathbar = true; # show path bar
        ShowStatusBar = true; # show status bar
      };

      # customize trackpad
      trackpad = {
        # tap - 轻触触摸板, click - 点击触摸板
        Clicking = true; # enable tap to click(轻触触摸板相当于点击)
        TrackpadRightClick = true; # enable two finger right click
        TrackpadThreeFingerDrag = true; # enable three finger drag
      };
    };

    keyboard = {
      enableKeyMapping = true; # enable key mapping so that we can use `option` as `control`

      remapCapsLockToControl = false; # remap caps lock to control, useful for emac users
      remapCapsLockToEscape = true; # remap caps lock to escape, useful for vim users

      # swap left command and left alt
      # so it matches common keyboard layout: `ctrl | command | alt`
      swapLeftCommandAndLeftAlt = false;

      # 将 Right Command (0x7000000E7) 映射为 F18 (0x70000006D)
      # 查表可得：
      # Right GUI (Command): 0x7000000E7 -> 十进制 30064771303
      # F18: 0x70000006D -> 十进制 30064771181
      userKeyMapping = [
        {
          HIDKeyboardModifierMappingSrc = 30064771303;
          HIDKeyboardModifierMappingDst = 30064771181;
        }
      ];
    };
  };

  # time.timeZone = "Asia/shanghai";

  # Add ability to used TouchID for sudo authentication
  security.pam.services.sudo_local.touchIdAuth = true;

  # Create /etc/zshrc that loads the nix-darwin environment.
  # this is required if you want to use darwin's default shell - zsh
  programs.zsh.enable = true;

  fonts = {
    packages = with pkgs; [
      # icon fonts
      material-design-icons
      font-awesome

      # nerdfonts
      nerd-fonts.symbols-only # symbols icon only
      nerd-fonts.fira-code
      nerd-fonts.jetbrains-mono
      nerd-fonts.iosevka
      nerd-fonts.fantasque-sans-mono
    ];
  };
}
