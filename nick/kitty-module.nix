{
  pkgs,
  ...
}: {
  programs.kitty = {
    enable = true;
    font = {
      package = pkgs.jetbrains-mono;
      name = "JetBrainsMono Nerd Font";
    };
    themeFile = "OneHalfDark";
    settings = {
      background_opacity = 0.8;
      dynamic_background_opacity = true;
      cursor_trail = 1;
      cursor_trail_decay = "0.1 0.4";
      cursor_trail_start_threshold = 1;
    };
    shellIntegration.enableZshIntegration = true;
  };
}
