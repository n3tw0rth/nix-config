{ pkgs, ... }:
{

  imports = [
    ./bash.nix
  ];

  home.packages = with pkgs; [
    sqlite
  ];
}
