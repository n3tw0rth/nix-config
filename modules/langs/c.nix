{ pkgs, ... }:
{
  home.packages = with pkgs; [
    gcc

    stdenv.cc
    glibc.dev
  ];
}
