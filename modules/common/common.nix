{
  config,
  lib,
  pkgs,
  ...
}:

{

  imports = [
    ./bash.nix
    ./nvim.nix
  ];

  options.modules.common.enable = lib.mkEnableOption "shell, aliases, and editor config";

  config = lib.mkIf config.modules.common.enable {

    # Common tools
    home.packages = with pkgs; [
      nixd
      nixfmt-rfc-style
      ripgrep
      fd
      fzf
      bat
      eza
      jq

      inetutils # ftp, hostname, telnet etc..
    ];
  };
}
