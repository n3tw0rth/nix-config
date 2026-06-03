{ pkgs, ... }:
{
  home.packages = with pkgs; [
    tmux
    sesh
  ];

  # imports = [ ./tmux/tmux-session-switcher/plugin.nix ];

  programs.tmux = {
    enable = true;
    plugins = with pkgs.tmuxPlugins; [
      {
        plugin = resurrect;
        extraConfig = ''
          resurrect_dir="$HOME/.tmux/resurrect"
          set -g @resurrect-dir $resurrect_dir
          set -g @resurrect-hook-post-save-all 'target=$(readlink -f $resurrect_dir/last); ...'
          set -g @resurrect-processes 'vim nvim'
        '';
      }
      {
        plugin = continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '5'
        '';
      }
      tmux-fzf
      fzf-tmux-url
      vim-tmux-navigator
    ];

    extraConfig = ''
      # local tmux plugins
      # run-shell ../../modules/packages/tmux/bin/tsm.tmux
      # run-shell ../../modules/packages/tmux/bin/pjs.tmux

      # set -g @resurrect-capture-pane-contents "on"
      # set -g @continuum-restore "on"

      # bind r source-file ~/.tmux.conf

      # Close panes and windows without confirmation
      bind-key x kill-pane
      bind-key & kill-window

      # Quiet
      set -g visual-activity off
      set -g visual-bell off
      set -g visual-silence off
      setw -g monitor-activity off
      set -g bell-action none

      # Enable mouse
      set -g mouse on

      # clock mode
      setw -g clock-mode-colour colour51

      # pane borders
      set -g pane-border-style "fg=colour242"
      set -g pane-active-border-style "fg=colour242"

      # statusbar
      set -g status on
      set -g status-position bottom
      set -g status-justify left
      set -g status-style "fg=colour35"
      # set -g status-left ""
      # set -g status-right ""
      set -g status-right-length 50
      set -g status-left-length 10

      setw -g window-status-current-style "fg=#9AA6B2 bg=#1A1A19 bold"
      setw -g window-status-current-format " #I #W #F "

      setw -g window-status-style "fg=#9AA6B2 dim"
      setw -g window-status-format " #I #W #F "

      setw -g window-status-bell-style "fg=colour2 bg=colour35 bold"

      # messages
      set -g message-style "fg=colour2 bg=colour0 bold"

      set-option -sg escape-time 10
      set-option -g default-terminal "screen-256color"

      # used in copy mode
      setw -g mode-keys vi
      setw -g mode-style "fg=colour1 bg=colour18 bold"
      bind -T copy-mode-vi v send-keys -X begin-selection
      bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "wl-copy"

      set -g mode-style "fg=colour0,bg=colour3"

      # clear all the history
      bind -n M-c send-keys C-l run-shell "tmux clear-history"

      # vim-tmux-navigator
      # set -g @vim_navigator_mapping_left "C-Left C-h"  # use C-h and C-Left
      # set -g @vim_navigator_mapping_right "C-Right C-l"
      # set -g @vim_navigator_mapping_up "C-k"
      # set -g @vim_navigator_mapping_down "C-j"
      # set -g @vim_navigator_mapping_prev ""  # removes the C-\ binding

      # Shift arrow to switch windows
      bind -n C-p  previous-window
      bind -n C-n next-window

      # create tmux new windows with the same path as in the current window
      bind c new-window -c "#{pane_current_path}"
      bind  %  split-window -h -c "#{pane_current_path}"
      bind '"' split-window -v -c "#{pane_current_path}"

      bind-key -n M-t run-shell '
        sesh connect $(sesh list | fzf-tmux -p) 
      '
    '';
  };
}
