{ pkgs, ... }:

{
  imports = [
    ./wordlists.nix
  ];

  home.packages = with pkgs; [
    # reconnaissance
    nmap
    rustscan
    gobuster
    ffuf
    netexec
    burpsuite
    caido

    # reversing
    radare2

    # misc
    python313Packages.impacket
  ];

}
