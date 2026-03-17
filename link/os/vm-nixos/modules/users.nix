{ pkgs, hostVars, ... }:

{
  users.defaultUserShell = pkgs.zsh;

  security.sudo.wheelNeedsPassword = false;

  users.users.${hostVars.user.name} = {
    isNormalUser = true;
    description = hostVars.user.description;
    extraGroups = hostVars.user.extraGroups;
    openssh.authorizedKeys.keys = hostVars.user.sshKeys;
  };
}
