{
  lib,
  config,
  pkgs,
  ...
}:
{
  options.modules.pwn.enable = lib.mkEnableOption "CTF and Cybersecurity tools";

  imports = [
    ./wordlists.nix
  ];

  config = lib.mkIf config.modules.pwn.enable {
    home.packages = with pkgs; [
      # reconnaissance
      nmap
      rustscan
      gobuster
      ffuf
      netexec
      caido
      ssh-audit

      # reversing
      radare2
      ghidra

      # misc
      python313Packages.impacket

      # crack
      hashid
      hashcat
      john
    ];
  };
}
