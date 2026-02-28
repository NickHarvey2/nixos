{
  home.file.toggleTouchpad = {
    target = "touchpad-toggle.sh";
    source = ./touchpad-toggle.sh;
    executable = true;
  };

  # Enable/disable touchpad
  wayland.windowManager.hyprland.settings.bind = [
    "$mainMod, T, execr, bash ~/touchpad-toggle.sh"
  ];
}
