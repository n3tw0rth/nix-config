{
  lib,
  ...
}:

{
  # Disable sway's built-in bar; waybar replaces it.
  wayland.windowManager.sway.config.bars = lib.mkForce [ ];

  programs.waybar = {
    enable = true;
    # Run waybar as a systemd user service bound to the sway session so it
    # starts reliably (survives reloads, restarts on crash).
    systemd.enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "bottom";
        height = 28;
        spacing = 8;
        modules-left = [
          "clock"
          "sway/window"
        ];
        modules-center = [ "sway/workspaces" ];
        modules-right = [
          "battery"
          "network"
          "disk"
          "pulseaudio"
        ];

        "clock" = {
          format = "{:%a %d %b  %H:%M}";
          tooltip-format = "<tt>{calendar}</tt>";
        };
        "sway/window" = {
          max-length = 60;
          format = "{title}";
        };
        "sway/workspaces" = {
          disable-scroll = true;
          format = "{name}";
        };
        "battery" = {
          format = "BAT {capacity}%";
          format-charging = "CHR {capacity}%";
          format-plugged = "AC {capacity}%";
          states = {
            warning = 30;
            critical = 15;
          };
        };
        "network" = {
          format-wifi = "WIFI {essid} {signalStrength}%";
          format-ethernet = "ETH";
          format-disconnected = "OFFLINE";
          tooltip-format = "{ifname}: {ipaddr}";
        };
        "disk" = {
          path = "/";
          format = "DISK {percentage_used}%";
        };
        "pulseaudio" = {
          format = "VOL {volume}%";
          format-muted = "MUTE";
          on-click = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
          on-click-right = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+";
        };
      };
    };
    style = ''
      * {
        font-family: "JetBrainsMono Nerd Font", monospace;
        font-size: 12px;
        min-height: 0;
        border: none;
        border-radius: 0;
      }

      window#waybar {
        background: #111111;
        color: #bbbbbb;
      }

      #workspaces button {
        background: transparent;
        color: #666666;
        padding: 0 8px;
      }

      #workspaces button.focused,
      #workspaces button.visible {
        color: #eeeeee;
        background: #2a2a2a;
      }

      #workspaces button.urgent {
        color: #ffffff;
        background: #444444;
      }

      #clock,
      #window,
      #battery,
      #network,
      #disk,
      #pulseaudio {
        padding: 0 10px;
        color: #bbbbbb;
      }

      #battery.warning {
        color: #999999;
      }

      #battery.critical {
        color: #ffffff;
      }

      #network.disconnected,
      #pulseaudio.muted {
        color: #555555;
      }
    '';
  };
}
