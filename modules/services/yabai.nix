{
  services.yabai = {
    enable = true; # until updated for macOS 26
    config = {
      layout = "bsp";
      top_padding = 16;
      bottom_padding = 16;
      left_padding = 16;
      right_padding = 16;
      window_gap = 16;
    };
    extraConfig = ''
      yabai -m rule --add app="^System Settings$" manage=off
      yabai -m rule --add app="^Finder$" manage=off
      yabai -m rule --add app="^java$" manage=off
      yabai -m rule --add app="^LuLu$" manage=off
    '';
  };
}
