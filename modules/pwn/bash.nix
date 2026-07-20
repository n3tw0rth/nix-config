{ pkgs, ... }:
{
  home.packages = [
    (pkgs.writeShellScriptBin "run.pwn-web" ''
      swaymsg 'workspace 3; exec caido-desktop'
    '')
  ];
}
