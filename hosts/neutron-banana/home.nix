{ config, pkgs, ... }:

{
  imports = [
    ../../modules/common/nvim.nix
  ];

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
      terminal = "kitty";
      startup = [
        { command = "swaybg -i ~/Pictures/wallpaper.jpg"; }
      ];
    };
  };

  programs.tmux = {
    enable = true;
    plugins = with pkgs; [
      tmuxPlugins.sensible
      tmuxPlugins.resurrect
      tmuxPlugins.tmux-fzf
      tmuxPlugins.fzf-tmux-url
    ];
  };

  programs.zoxide.enableBashIntegration = true;
  programs.zoxide.enable = true;

  home.packages = with pkgs; [
    swaybg
    tmux
    zoxide
    lazygit
    openvpn
  ];

}
