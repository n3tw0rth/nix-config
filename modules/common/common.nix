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

    home.packages = with pkgs; [
      vscode
      bat
      brave
      btop
      eza
      fd
      fzf
      file
      inetutils # ftp, hostname, telnet etc..
      jq
      nixd
      nixfmt-rfc-style
      ripgrep
    ];
  };
}
