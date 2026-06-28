{
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ../../modules/langs/index.nix
    ../../modules/programs/index.nix
    ../../modules/pwn/pwn.nix
    ../../modules/common/common.nix
  ];

  modules.pwn.enable = true;
  modules.common.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "n3tw0rth";
  home.homeDirectory = "/home/n3tw0rth";

  home.stateVersion = "25.11";

  programs.home-manager.enable = true;

  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true; # Fixes common issues with GTK 3 apps
    config = rec {
      modifier = "Mod1";
      # Use kitty as default terminal
      terminal = "terminator";
      startup = [
        { command = "swaybg -i ~/Pictures/wallpaper.png"; }
      ];
    };
  };

  wayland.windowManager.sway.config.keybindings = lib.mkOptionDefault {
    "Mod1+l" = "focus next sibling";
    "Mod1+h" = "focus prev";
  };

  programs.zoxide.enableBashIntegration = true;
  programs.zoxide.enable = true;

  home.packages = with pkgs; [
    swaybg
    tmux
    zoxide
    lazygit
    openvpn
    just
    fzf
    ripgrep

    nmap
    nautilus

    moreutils
    bat
    pluma
    unzip

    postman
    waybar
    glibc.dev
    gcr
  ];
}
