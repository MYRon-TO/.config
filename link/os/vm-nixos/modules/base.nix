{ hostVars, ... }:

{
  time.timeZone = hostVars.timeZone;

  i18n.defaultLocale = hostVars.defaultLocale;

  console = {
    font = "Lat2-Terminus16";
    keyMap = hostVars.consoleKeyMap;
  };

  networking.networkmanager.enable = true;

  nixpkgs.config.allowUnfree = hostVars.allowUnfree;
}
