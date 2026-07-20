{ pkgs, ... }:
{
  home.packages = [
    (pkgs.writeShellScriptBin "run.dev" ''
      swaymsg 'workspace 3; exec postman'
    '')
  ];
}
