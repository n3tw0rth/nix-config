{ ... }:

{
  imports = [ ./swaywm/screenshot.nix ];

  home.sessionVariables = {
    _JAVA_AWT_WM_NONREPARENTING = "1";
  };

  # wayland.windowManager.sway.config = {
  #   workspaceAutoBackAndForth = true;
  # };

  wayland.windowManager.sway.extraConfig = ''
    assign [app_id="firefox"] workspace 10
    assign [app_id="Caido"] workspace 3
    assign [app_id="Postman"] workspace 3
    assign [class="ghidra-Ghidra"] workspace 3

    exec swaymsg 'workspace 10; exec firefox'
    exec swaymsg "workspace 9; exec terminator -e 'tmux attach -t nixos || tmux new -s nixos'"
    exec swaymsg "workspace 1; exec terminator -e 'tmux a'"
    exec swaymsg "workspace 6; exec terminator -e 'cd /tmp && vi tmpnotes'"
  '';
}
