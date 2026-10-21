{pkgs, ...}: {
  programs.labwc.enable = true;
  programs.dconf.enable = true;
  security.polkit.enable = true;
  services.udisks2.enable = true;
  services.dbus.enable = true;
  services.greetd = {
    enable = true;
    settings.default_session = {
      user = "greeter";
      command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --cmd labwc";
    };
  };

  hardware.graphics.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    material-design-icons
    font-awesome
    nerd-fonts.symbols-only
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    nerd-fonts.iosevka
    nerd-fonts.fantasque-sans-mono
  ];
}
