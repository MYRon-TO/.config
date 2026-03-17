{ lib, hostVars, ... }:

{
  services.openssh = {
    enable = hostVars.openssh.enable;
    settings = {
      PasswordAuthentication = hostVars.openssh.passwordAuthentication;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = hostVars.openssh.permitRootLogin;
    };
  };

  services.qemuGuest.enable = hostVars.qemuGuestEnable;
  services.spice-vdagentd.enable = lib.mkDefault hostVars.spiceAgentEnable;

  programs.command-not-found.enable = true;
}
