{
  ...
}:{

programs.kitty = {
  enable = true;
  font = {
    name = "JetBrainsMono Nerd Font Thin";

    size = 10;
  };
  settings = {
    text_composition_strategy = "1.0 0";
    modify_font = "cell_height 102%";

    cursor_shape = "block";
    cursor_blink_interval = 0;

    scrollback_lines = 10000;

    window_padding_width = 8;
    hide_window_decorations = true;

    repaint_delay = 10;
    input_delay = 3;
    sync_to_monitor = true;

    enable_audio_bell = false;

    tab_bar_style = "powerline";
    tab_powerline_style = "slanted";
  };
};
}
