{ ... }:
{
  programs.kitty = {
    enable = true;
    font = {
      name = "FiraCode Nerd Font";
      size = 12;
    };
    themeFile = "Catppuccin-Latte";
    settings = {
      enable_audio_bell = false;
      window_padding_width = 10;
      cursor_shape = "beam";
      cursor_trail = 100;
      tab_bar_align = "center";
      confirm_os_window_close = 0;
      detect_urls = true;
      strip_trailing_spaces = "smart";
      scrollback_lines = 10000;
    };
  };
}