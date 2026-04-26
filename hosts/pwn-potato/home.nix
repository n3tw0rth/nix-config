{ config, pkgs, ... }:

{
  imports = [
    ../../modules/langs/index.nix
    ../../modules/programs/index.nix
    ../../modules/pwn/index.nix
  ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "n3tw0rth";
  home.homeDirectory = "/home/n3tw0rth";

  home.stateVersion = "25.11";

  programs.home-manager.enable = true;

  programs.bash = {
    enable = true;
    shellAliases = {
      g = "git";
      ll = "ls -al";
      vi = "nvim";
      lg = "lazygit";
    };

    bashrcExtra = ''
      set -o vi

      export EDITOR=nvim
    '';
  };

  programs.neovim.enable = true;

  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true; # Fixes common issues with GTK 3 apps
    config = rec {
      modifier = "Mod1";
      # Use kitty as default terminal
      terminal = "terminator";
      startup = [
        { command = "swaybg -i ~/Pictures/wallpaper.jpg"; }
      ];
    };
  };

  programs.zoxide.enableBashIntegration = true;
  programs.zoxide.enable = true;

  home.packages = with pkgs; [
    python314

    swaybg
    tmux
    zoxide
    lazygit
    openvpn
    just
    fzf
    ripgrep

    burpsuite
    nmap
    nautilus

    killall # dependecy used in polybar launch.sh
    moreutils
    bat
    pluma
  ];
}
