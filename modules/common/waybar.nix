{
  lib,
  pkgs,
  ...
}:

let
  # Reports Claude subscription usage (the /usage screen) for the custom/claude
  # waybar module: current-session % in the bar, session + weekly + resets in the
  # tooltip. Reads the local OAuth token from ~/.claude/.credentials.json and
  # queries Anthropic's usage endpoint. The token can only be refreshed by running
  # Claude Code, so on expiry/error the module shows a dim refresh hint.
  claudeUsage = pkgs.writeShellApplication {
    name = "waybar-claude-usage";
    runtimeInputs = [
      pkgs.curl
      pkgs.jq
      pkgs.coreutils
    ];
    text = ''
      creds="$HOME/.claude/.credentials.json"
      tok=$(jq -r '.claudeAiOauth.accessToken // empty' "$creds" 2>/dev/null || true)
      exp=$(jq -r '.claudeAiOauth.expiresAt // 0' "$creds" 2>/dev/null || echo 0)
      now_ms=$(( $(date +%s) * 1000 ))

      if [ -z "$tok" ] || [ "$exp" -lt "$now_ms" ]; then
        echo '{"text":"CLAUDE ⟳","tooltip":"Claude token expired — run claude to refresh","class":"expired"}'
        exit 0
      fi

      resp=$(curl -sS --max-time 8 https://api.anthropic.com/api/oauth/usage \
        -H "Authorization: Bearer $tok" \
        -H "anthropic-beta: oauth-2025-04-20" 2>/dev/null || true)

      if ! echo "$resp" | jq -e '.five_hour' >/dev/null 2>&1; then
        echo '{"text":"CLAUDE ⟳","tooltip":"Could not fetch Claude usage (token may need refresh)","class":"expired"}'
        exit 0
      fi

      sess=$(echo "$resp" | jq -r '(.five_hour.utilization // 0) | round')
      week=$(echo "$resp" | jq -r '(.seven_day.utilization // 0) | round')
      sess_reset=$(echo "$resp" | jq -r '.five_hour.resets_at // empty')
      week_reset=$(echo "$resp" | jq -r '.seven_day.resets_at // empty')

      reset_in() {
        [ -z "$1" ] && { echo "?"; return; }
        target=$(date -d "$1" +%s 2>/dev/null) || { echo "?"; return; }
        diff=$(( target - $(date +%s) ))
        [ "$diff" -lt 0 ] && { echo "now"; return; }
        d=$(( diff / 86400 )); h=$(( (diff % 86400) / 3600 )); m=$(( (diff % 3600) / 60 ))
        if [ "$d" -gt 0 ]; then echo "''${d}d ''${h}h";
        elif [ "$h" -gt 0 ]; then echo "''${h}h ''${m}m";
        else echo "''${m}m"; fi
      }
      sess_h=$(reset_in "$sess_reset")
      week_h=$(reset_in "$week_reset")

      breakdown=$(echo "$resp" | jq -r '
        .seven_day_breakdown.rows // []
        | map(select(.percent > 0) | "  " + .display_name + ": " + (.percent|tostring) + "%")
        | join("\n")')

      # severity from the larger of the two percentages
      maxp=$sess; [ "$week" -gt "$maxp" ] && maxp=$week
      if   [ "$maxp" -ge 95 ]; then cls=critical
      elif [ "$maxp" -ge 80 ]; then cls=warning
      else cls=normal; fi

      jq -cn \
        --arg sess "$sess" --arg week "$week" \
        --arg sh "$sess_h" --arg wh "$week_h" \
        --arg bd "$breakdown" --arg c "$cls" '
        {
          text: ("CLAUDE " + $sess + "%"),
          tooltip: (
            "Session: " + $sess + "% used (resets in " + $sh + ")\n" +
            "Weekly (all models): " + $week + "% used (resets in " + $wh + ")" +
            (if $bd == "" then "" else "\nWeekly breakdown:\n" + $bd end)
          ),
          class: $c
        }'
    '';
  };
in
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
          "custom/claude"
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
        "custom/claude" = {
          format = "{}";
          return-type = "json";
          exec = "${claudeUsage}/bin/waybar-claude-usage";
          interval = 120;
          tooltip = true;
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
      #pulseaudio,
      #custom-claude {
        padding: 0 10px;
        color: #bbbbbb;
      }

      #custom-claude.warning {
        color: #dddddd;
      }

      #custom-claude.critical {
        color: #ffffff;
        background: #444444;
      }

      #custom-claude.expired {
        color: #555555;
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
