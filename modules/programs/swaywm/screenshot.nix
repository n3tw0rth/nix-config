{ config, lib, pkgs, ... }:
let
  # Helper for saving with a timestamp
  screenshot_path = "DIR=~/Pictures/Screenshots; mkdir -p $DIR; $DIR/$(date +'%Y-%m-%d_%H:%M:%S').png";
  mod = "Mod4"; # Usually the Super key
in
{
  wayland.windowManager.sway.config.keybindings = lib.mkOptionDefault {
    # Fullscreen screenshot
    "Print" = "exec grim /home/$USER/Pictures/$(date +'%Y-%m-%d_%H:%M:%S').png";

    # Active window (Sway specific)
    "${mod}+Print" = "exec swaymsg -t get_tree | jq -r '.. | select(.focused? == true).rect | \"\\(.x),\\(.y) \\(.width)x\\(.height)\"' | grim -g - /home/$USER/Pictures/$(date +'%Y-%m-%d_%H:%M:%S').png";

    # Select region
    "Ctrl+Shift+Print" = "exec grim -g \"$(slurp)\" /home/$USER/Pictures/$(date +'%Y-%m-%d_%H:%M:%S').png";

    # Clipboard Screenshots
    "Ctrl+Print" = "exec grim - | wl-copy";
    "Ctrl+Shift+s" = "exec grim -g \"$(slurp)\" - | wl-copy";
  };
}
