{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # reconnaissance
    nmap
    rustscan

    # reversing
    radare2

    # misc
    python313Packages.impacket
  ];

}
