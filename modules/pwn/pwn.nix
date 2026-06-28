{
  lib,
  config,
  pkgs,
  ...
}:
{

  imports = [
    ./wordlists.nix
    ./ghidra.nix
  ];

  options.modules.pwn.enable = lib.mkEnableOption "CTF and Cybersecurity tools";

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
      ltrace
      strace

      # misc
      python313Packages.impacket
      metasploit

      # crack
      hashid
      hashcat
      john

      #bruteforce
      sqlmap
    ];
  };
}
