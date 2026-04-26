{ pkgs, ... }:

let
  session-switcher = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "session-switcher";
    version = "1.0";

    src = pkgs.runCommand "session-switcher-src" { } ''
            mkdir -p $out/scripts

            cat > $out/scripts/switch.sh <<'EOF'
      #!/usr/bin/env bash
      set -euo pipefail

      TMUX_BIN="@tmux@"
      FZF_BIN="@fzf@"

      SESSION_NAME="$($TMUX_BIN ls 2>/dev/null | awk -F':' '{print $1}' | $FZF_BIN -p --reverse)"

      if [ -n "${SESSION_NAME:-}" ]; then
        $TMUX_BIN switch-client -t "$SESSION_NAME"
      fi
      EOF

            chmod +x $out/scripts/switch.sh

            cat > $out/session-switcher.tmux <<'EOF'
      bind-key -n M-t run-shell "#{plugin_path}/scripts/switch.sh"
      EOF

            # substitute placeholders safely
            substituteInPlace $out/scripts/switch.sh \
              --replace "@tmux@" "${pkgs.tmux}/bin/tmux" \
              --replace "@fzf@" "${pkgs.fzf}/bin/fzf-tmux"
    '';
  };

in
{
  home.packages = [ pkgs.fzf ];

  programs.tmux = {
    enable = true;
    plugins = [ session-switcher ];
  };
}
