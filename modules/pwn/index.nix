{ pkgs, ... }:

{
  imports = [ ./wordlists.nix ./hosts.nix ];
  home.packages = with pkgs; [
    # reconnaissance
    nmap
    rustscan
    gobuster
    ffuf

    # reversing
    radare2

    # misc
    python313Packages.impacket
  ];

}
