{ pkgs, hostVars, ... }:

let
  resolvePkg = name: builtins.getAttr name pkgs;
in
{
  environment.systemPackages = map resolvePkg hostVars.devPackages;

  environment.variables = {
    EDITOR = hostVars.editor;
    VISUAL = hostVars.editor;
  };

  programs.vim = {
    enable = builtins.elem "vim" hostVars.devPackages;
    defaultEditor = hostVars.editor == "vim";
  };

  programs.zsh.enable = true;
}
