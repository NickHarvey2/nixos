{pkgs, ...}: {
  home.packages = with pkgs; [
    rofi-power-menu
    rofi-network-manager
    rofi-rbw-wayland
  ];

  programs = {
    hyprlock = {
      enable = true;
      settings = {
        widget_name = {
          monitor = ""; # leave empty for all monitors
        };
        background = {
          monitor = "";
          path = "~/background";
          color = "rgba(25, 20, 20, 1.0)";
          # all these options are taken from hyprland, see https://wiki.hyprland.org/Configuring/Variables/#blur for explanations
          blur_passes = 0; # 0 disables blurring
          blur_size = 7;
          noise = 0.0117;
          contrast = 0.8916;
          brightness = 0.8172;
          vibrancy = 0.1696;
          vibrancy_darkness = 0.0;
        };
        input-field = {
          monitor = "";
          size = "200, 50";
          outline_thickness = 3;
          dots_size = 0.33; # Scale of input-field height, 0.2 - 0.8
          dots_spacing = 0.15; # Scale of dots' absolute size, 0.0 - 1.0
          dots_center = false;
          dots_rounding = -1; # -1 default circle, -2 follow input-field rounding
          outer_color = "rgb(151515)";
          inner_color = "rgb(200, 200, 200)";
          font_color = "rgb(10, 10, 10)";
          fade_on_empty = true;
          fade_timeout = 1000; # Milliseconds before fade_on_empty is triggered.
          placeholder_text = "<i>Input Password...</i>"; # Text rendered in the input box when it's empty.
          hide_input = false;
          rounding = -1; # -1 means complete rounding (circle/oval)
          check_color = "rgb(204, 136, 34)";
          fail_color = "rgb(204, 34, 34)"; # if authentication failed, changes outer_color and fail message color
          fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>"; # can be set to empty
          fail_timeout = 2000; # milliseconds before fail_text and fail_color disappears
          fail_transition = 300; # transition time in ms between normal outer_color and fail_color
          capslock_color = -1;
          numlock_color = -1;
          bothlock_color = -1; # when both locks are active. -1 means don't change outer color (same for above)
          invert_numlock = false; # change color if numlock is off
          swap_font_color = false; # see below

          position = "0, -20";
          halign = "center";
          valign = "center";
        };
        label = {
          monitor = "";
          text = "Welcome, $USER";
          text_align = "center"; # center/right or any value for default left. multi-line text alignment inside label container
          color = "rgba(200, 200, 200, 1.0)";
          font_size = 25;
          font_family = "Noto Sans";
          rotate = 0; # degrees, counter-clockwise

          position = "0, 80";
          halign = "center";
          valign = "center";
        };
      };
    };
    waybar = {
      enable = true;
      settings = {
        topBar = {
          height = 30;
          spacing = 4;
          modules-left = [
            "hyprland/workspaces"
          ];
          modules-center = [
            "hyprland/window"
          ];
          modules-right = [
            "pulseaudio"
            "network"
            "cpu"
            "memory"
            "temperature"
            "battery"
            "idle_inhibitor"
            "clock"
          ];
          "hyprland/workspaces" = {
            disable-scroll = true;
            all-outputs = true;
            warp-on-scroll = false;
            format = "{icon} ";
            format-icons = {
              "1" = "";
              "2" = "󰖟";
              "3" = "";
              "4" = "";
              "5" = "";
              "6" = "󰓓";
              "7" = "󰲬";
              "8" = "󰲮";
              "9" = "󰲰";
              focused = "";
              default = "";
            };
            persistent-workspaces = {
              "*" = [1 2 3 4 5 6];
            };
          };
          idle_inhibitor = {
            format = "{icon}";
            format-icons = {
              activated = "󰅶";
              deactivated = "󰾫";
            };
          };
          clock = {
            tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
            format-alt = "{:%Y-%m-%d}";
          };
          cpu = {
            format = "{usage}% ";
            tooltip = false;
          };
          memory = {
            format = "{}% ";
          };
          temperature = {
            critical-threshold = 80;
            format = "{temperatureC}°C {icon}";
            format-icons = ["" "" ""];
          };
          battery = {
            states = {
              warning = 30;
              critical = 15;
            };
            format = "{capacity}% {icon}";
            format-full = "{capacity}% {icon}";
            format-charging = "{capacity}% ";
            format-plugged = "{capacity}% ";
            format-alt = "{time} {icon}";
            format-icons = ["" "" "" "" ""];
          };
          network = {
            format-wifi = "{essid} ({signalStrength}%) ";
            format-ethernet = "{ipaddr}/{cidr} 󰛳";
            tooltip-format = "{ifname} via {gwaddr} 󰒄";
            format-linked = "{ifname} (No IP) ⚠";
            format-disconnected = "Disconnected ⚠";
            on-click = "rofi-network-manager";
          };
          pulseaudio = {
            format = "{volume}% {icon}  {format_source}";
            format-bluetooth = "{volume}% {icon}  {format_source}";
            format-bluetooth-muted = "  {icon}  {format_source}";
            format-muted = "0%   {format_source}";
            format-source = "{volume}% ";
            format-source-muted = "";
            format-icons = {
              default = [" " " " " "];
            };
            on-click = "pavucontrol";
          };
        };
      };
      style = builtins.readFile ./waybar.style.css;
    };
    rofi = {
      enable = true;
      modes = ["drun" "run"];
      theme = "solarized";
    };
  };

  services = {
    mako = {
      enable = true;
    };
    hyprpaper = {
      enable = true;
      settings = {
        preload = "~/background";
        wallpaper = ", ~/background";
      };
    };
    hypridle = {
      enable = true;
      settings = {
        general = {
          # avoid running multiple hyprlock instances
          lock_cmd = "pidof hyprlock || hyprlock";
          before_sleep_cmd = "loginctl lock-session";
          after_sleep_cmd = "hyprctl dispatch dpms on";
        };
      };
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      # See https://wiki.hyprland.org/Configuring/Monitors/
      monitor = ",preferred,auto,1";

      # See https://wiki.hyprland.org/Configuring/Keywords/

      # Set programs that you use
      "$terminal" = "kitty";
      # $fileManager = yazi
      "$menu" = "rofi -show drun -show-icons";

      # Autostart necessary processes (like notifications daemons, status bars, etc.)
      exec-once = [
        "waybar &"
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

      # https://wiki.hyprland.org/Configuring/Variables/#ecosystem
      ecosystem = {
        no_update_news = true;
        no_donation_nag = true;
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
        kb_options = "caps:swapescape";
        numlock_by_default = true;
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
        "$mainMod, B, exec, rofi-rbw --clear-after 15 --keybindings 'Alt+1:copy:username,Alt+2:copy:password'"
        "$mainMod, W, exec, rofi -show windows -modes \"windows:$FLAKE_DIR/window-picker.sh\""
        "$mainMod, N, exec, rofi-network-manager"
        "$mainMod, F, fullscreen"
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
      windowrulev2 = [
        "suppressevent maximize, class:.*" # You'll probably like this.
        "fullscreen, title:^(kitty-full)$"
        "animation none, title:^(kitty-full)$"
      ];
    };
  };
}
