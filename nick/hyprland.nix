{
  lib,
  kb_opts
}: {
  # See https://wiki.hyprland.org/Configuring/Monitors/
  monitor = ",preferred,auto,1";

  # See https://wiki.hyprland.org/Configuring/Keywords/

  # Set programs that you use
  "$terminal" = "kitty";
  # $fileManager = yazi
  "$menu" = "rofi -show drun -show-icons";

  # Autostart necessary processes (like notifications daemons, status bars, etc.)
  exec-once = [
    "udiskie &"
    "nm-applet &"
    "waybar &"
    "hyprpaper"
    "hypridle"
  ];

  # See https://wiki.hyprland.org/Configuring/Environment-variables/
  env = [
    "XCURSOR_SIZE,24"
    "HYPRCURSOR_SIZE,24"
  ];

  # https://wiki.hyprland.org/Configuring/Variables/#general
  general = {
    gaps_in = 3;
    gaps_out = 3;
    border_size = 3;
    # https://wiki.hyprland.org/Configuring/Variables/#variable-types for info about colors
    "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
    "col.inactive_border" = "rgba(595959aa)";
    # Set to true enable resizing windows by clicking and dragging on borders and gaps
    resize_on_border = false;
    # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
    allow_tearing = false;
    layout = "dwindle";
  };

  # https://wiki.hyprland.org/Configuring/Variables/#decoration
  decoration = {
    rounding = 3;
    # Change transparency of focused and unfocused windows
    active_opacity = 1.0;
    inactive_opacity = 1.0;
    # drop_shadow = true;
    # shadow_range = 4;
    # shadow_render_power = 3;
    # col.shadow = rgba(1a1a1aee);
    # https://wiki.hyprland.org/Configuring/Variables/#blur
    blur = {
      enabled = true;
      size = 3;
      passes = 1;
      vibrancy = 0.1696;
    };
  };

  # https://wiki.hyprland.org/Configuring/Variables/#animations
  animations = {
    enabled = true;
    # Default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more
    bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
    animation = [
      "windows, 1, 7, myBezier"
      "windowsOut, 1, 7, default, popin 80%"
      "border, 1, 10, default"
      "borderangle, 1, 8, default"
      "fade, 1, 7, default"
      "workspaces, 1, 6, default"
    ];
  };

  # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
  dwindle = {
    pseudotile = true; # Master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
    preserve_split = true; # You probably want this
    single_window_aspect_ratio = "16 9"; # limit max width of a window to make dwindle on an ultrawide not terrible
  };

  # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
  master = {
    new_status = "master";
    orientation = "center";
  };

  # https://wiki.hyprland.org/Configuring/Variables/#misc
  misc = {
    force_default_wallpaper = 0; # Set to 0 or 1 to disable the anime mascot wallpapers
    disable_hyprland_logo = true; # If true disables the random hyprland logo / anime girl background. :(
  };

  cursor = {
    hide_on_key_press = true;
    inactive_timeout = 10;
  };

  # https://wiki.hyprland.org/Configuring/Variables/#input
  input = {
    kb_layout = "us";
    # swap caps and escape on nixos1 and nixos3
    kb_options = kb_opts;
    follow_mouse = 1;
    sensitivity = 0; # -1.0 - 1.0, 0 means no modification.
    touchpad = {
      natural_scroll = true;
      clickfinger_behavior = 1;
    };
  };

  # See https://wiki.hyprland.org/Configuring/Keywords/
  "$mainMod" = "SUPER"; # Sets "Windows" key as main modifier

  # See https://wiki.hyprland.org/Configuring/Binds/ for more
  bind = [
    "$mainMod, Q, exec, $terminal"
    "$mainMod, C, killactive,"
    "$mainMod, M, exit,"
    "$mainMod, P, pseudo, # dwindle"
    "$mainMod, J, togglesplit, # dwindle"
    "$mainMod SHIFT, L, movewindow, r"
    "$mainMod SHIFT, H, movewindow, l"
    "$mainMod SHIFT, J, movewindow, d"
    "$mainMod SHIFT, K, movewindow, u"
    "$mainMod, Space, exec, $menu"
    "$mainMod, F, fullscreen"
    # Enable/disable touchpad
    "$mainMod, T, execr, bash ~/touchpad-toggle.sh"
    # Move focus with mainMod + arrow keys
    "$mainMod, left, movefocus, l"
    "$mainMod, right, movefocus, r"
    "$mainMod, up, movefocus, u"
    "$mainMod, down, movefocus, d"
    # Switch workspaces with mainMod + [0-9]
    "$mainMod, 1, workspace, 1"
    "$mainMod, 2, workspace, 2"
    "$mainMod, 3, workspace, 3"
    "$mainMod, 4, workspace, 4"
    "$mainMod, 5, workspace, 5"
    "$mainMod, 6, workspace, 6"
    "$mainMod, 7, workspace, 7"
    "$mainMod, 8, workspace, 8"
    "$mainMod, 9, workspace, 9"
    "$mainMod, 0, workspace, 10"
    # Move active window to a workspace with mainMod + SHIFT + [0-9]
    "$mainMod SHIFT, 1, movetoworkspace, 1"
    "$mainMod SHIFT, 2, movetoworkspace, 2"
    "$mainMod SHIFT, 3, movetoworkspace, 3"
    "$mainMod SHIFT, 4, movetoworkspace, 4"
    "$mainMod SHIFT, 5, movetoworkspace, 5"
    "$mainMod SHIFT, 6, movetoworkspace, 6"
    "$mainMod SHIFT, 7, movetoworkspace, 7"
    "$mainMod SHIFT, 8, movetoworkspace, 8"
    "$mainMod SHIFT, 9, movetoworkspace, 9"
    "$mainMod SHIFT, 0, movetoworkspace, 10"
    # Example special workspace (scratchpad)
    "$mainMod, grave, togglespecialworkspace, magic"
    "$mainMod SHIFT, grave, movetoworkspace, special:magic"
    # Move/resize window with mainMod + keys
    "$mainMod CTRL, right, resizeactive, 50 0"
    "$mainMod CTRL, left, resizeactive, -50 0"
    "$mainMod CTRL, up, resizeactive, 0 -50"
    "$mainMod CTRL, down, resizeactive, 0 50"
    "$mainMod SHIFT, left, movewindow, l"
    "$mainMod SHIFT, right, movewindow, r"
    "$mainMod SHIFT, up, movewindow, u"
    "$mainMod SHIFT, down, movewindow, d"
    # Dismiss mako notifications
    "$mainMod, D, exec, makoctl dismiss"
  ];

  bindel = [
    # Volume keys
    ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 10%+"
    ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 10%-"
    # Backlight
    ", XF86MonBrightnessUp, exec, brightnessctl set 5%+"
    ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"
  ];

  bindl = [
    # Mute key
    ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
    # Lock with super-L because I've got Windows brain rot
    "$mainMod, L, exec, hyprlock"
    # Lock on lid close
    ", switch:Lid Switch, exec, hyprlock"
  ];

  # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more
  # See https://wiki.hyprland.org/Configuring/Workspace-Rules/ for workspace rules
  # Example windowrule v1
  # windowrule = float, ^(kitty)$
  # Example windowrule v2
  # windowrulev2 = float,class:^(kitty)$,title:^(kitty)$
  windowrulev2 = "suppressevent maximize, class:.*"; # You'll probably like this.
}
