{
  pkgs,
  lib,
  ...
}: let
  mainMod = "SUPER";
  terminal = "kitty";
in {
  home.packages = with pkgs; [
    wl-kbptr
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
      modes = ["drun" "run" "window"];
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
        splash = false;
        wallpaper = {
          # monitor = "HDMI-A-1";
          monitor = ""; # set to empty to make this the fallback wallpaper
          path = "~/background";
          fit_mode = "cover";
        };
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
    xwayland.enable = true;
    configType = "lua";
    settings = {
      monitor = [
        {
          output = "HDMI-A-1";
          mode = "5120x1440";
          position = "auto";
          scale = "1";
        }
        {
          output = "";
          mode = "preferred";
          position = "auto";
          scale = "1";
        }
      ];

      on._args = ["hyprland.start" (lib.generators.mkLuaInline "function() hl.exec_cmd('waybar') end")];

      config = {
        cursor = {
          hide_on_key_press = true;
          inactive_timeout = 10;
        };
        input = {
          kb_layout = "us";
          kb_options = "caps:swapescape";
          numlock_by_default = true;
          follow_mouse = 1;
          repeat_delay = 200;
          repeat_rate = 40;
          touchpad = {
            natural_scroll = true;
            clickfinger_behavior = true;
          };
        };
        decoration = {
          rounding = 3;
          active_opacity = 1.0;
          inactive_opacity = 1.0;
          blur = {
            enabled = true;
            size = 3;
            passes = 1;
            vibrancy = 0.1696;
          };
        };
        general = {
          gaps_in = 3;
          gaps_out = 3;
          border_size = 3;
          "col.active_border" = lib.generators.mkLuaInline "{colors={'rgba(33ccffee)','rgba(00ff99ee)'},angle=45}";
          "col.inactive_border" = "0x595959aa";
          resize_on_border = false;
          # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
          allow_tearing = false;
          layout = "dwindle";
        };
        layout = {
          single_window_aspect_ratio = "16 9"; # limit max width of a window to make dwindle on an ultrawide not terrible
        };
        ecosystem = {
          no_update_news = true;
          no_donation_nag = true;
        };
        animations = {
          enabled = true;
          # bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
          # animation = [
          #   "windows, 1, 7, myBezier"
          #   "windowsOut, 1, 7, default, popin 80%"
          #   "border, 1, 10, default"
          #   "borderangle, 1, 8, default"
          #   "fade, 1, 7, default"
          #   "workspaces, 1, 6, default"
          # ];
        };
        dwindle = {
          preserve_split = true; # You probably want this
        };
        master = {
          new_status = "master";
          orientation = "center";
        };
        misc = {
          force_default_wallpaper = 0; # Set to 0 or 1 to disable the anime mascot wallpapers
          disable_hyprland_logo = true; # If true disables the random hyprland logo
        };
      };

      bind = [
        {_args = ["${mainMod} + Q" (lib.generators.mkLuaInline "hl.dsp.exec_cmd('${terminal}')")];}
        {_args = ["${mainMod} + Space" (lib.generators.mkLuaInline "hl.dsp.exec_cmd('rofi -show drun -show-icons')")];}
        {_args = ["${mainMod} + B" (lib.generators.mkLuaInline "hl.dsp.exec_cmd('rofi-rbw --clear-after 15 --keybindings Alt+1:copy:username,Alt+2:copy:password')")];}
        {_args = ["${mainMod} + W" (lib.generators.mkLuaInline "hl.dsp.exec_cmd('rofi -show window')")];}
        {_args = ["${mainMod} + N" (lib.generators.mkLuaInline "hl.dsp.exec_cmd('rofi-network-manager')")];}
        {_args = ["${mainMod} + D" (lib.generators.mkLuaInline "hl.dsp.exec_cmd('makoctl dismiss')")];} # Dismiss mako notifications
        {_args = ["${mainMod} + C" (lib.generators.mkLuaInline "hl.dsp.window.kill()")];}
        {_args = ["${mainMod} + M" (lib.generators.mkLuaInline "hl.dsp.exec_cmd('uwsm stop')")];}
        {_args = ["${mainMod} + P" (lib.generators.mkLuaInline "hl.dsp.exec_cmd('wl-kbptr -o modes=split')")];}
        # # Switch workspaces with mainMod + [0-9]
        {_args = ["${mainMod} + 1" (lib.generators.mkLuaInline "hl.dsp.focus({workspace=1})")];}
        {_args = ["${mainMod} + 2" (lib.generators.mkLuaInline "hl.dsp.focus({workspace=2})")];}
        {_args = ["${mainMod} + 3" (lib.generators.mkLuaInline "hl.dsp.focus({workspace=3})")];}
        {_args = ["${mainMod} + 4" (lib.generators.mkLuaInline "hl.dsp.focus({workspace=4})")];}
        {_args = ["${mainMod} + 5" (lib.generators.mkLuaInline "hl.dsp.focus({workspace=5})")];}
        {_args = ["${mainMod} + 6" (lib.generators.mkLuaInline "hl.dsp.focus({workspace=6})")];}
        {_args = ["${mainMod} + 7" (lib.generators.mkLuaInline "hl.dsp.focus({workspace=7})")];}
        {_args = ["${mainMod} + 8" (lib.generators.mkLuaInline "hl.dsp.focus({workspace=8})")];}
        {_args = ["${mainMod} + 9" (lib.generators.mkLuaInline "hl.dsp.focus({workspace=9})")];}
        {_args = ["${mainMod} + 0" (lib.generators.mkLuaInline "hl.dsp.focus({workspace=10})")];}
        # # Move active window to a workspace with mainMod + SHIFT + [0-9]
        {_args = ["${mainMod} + SHIFT + 1" (lib.generators.mkLuaInline "hl.dsp.window.move({workspace=1,follow=true})")];}
        {_args = ["${mainMod} + SHIFT + 2" (lib.generators.mkLuaInline "hl.dsp.window.move({workspace=2,follow=true})")];}
        {_args = ["${mainMod} + SHIFT + 3" (lib.generators.mkLuaInline "hl.dsp.window.move({workspace=3,follow=true})")];}
        {_args = ["${mainMod} + SHIFT + 4" (lib.generators.mkLuaInline "hl.dsp.window.move({workspace=4,follow=true})")];}
        {_args = ["${mainMod} + SHIFT + 5" (lib.generators.mkLuaInline "hl.dsp.window.move({workspace=5,follow=true})")];}
        {_args = ["${mainMod} + SHIFT + 6" (lib.generators.mkLuaInline "hl.dsp.window.move({workspace=6,follow=true})")];}
        {_args = ["${mainMod} + SHIFT + 7" (lib.generators.mkLuaInline "hl.dsp.window.move({workspace=7,follow=true})")];}
        {_args = ["${mainMod} + SHIFT + 8" (lib.generators.mkLuaInline "hl.dsp.window.move({workspace=8,follow=true})")];}
        {_args = ["${mainMod} + SHIFT + 9" (lib.generators.mkLuaInline "hl.dsp.window.move({workspace=9,follow=true})")];}
        {_args = ["${mainMod} + SHIFT + 0" (lib.generators.mkLuaInline "hl.dsp.window.move({workspace=10,follow=true})")];}
        {_args = ["${mainMod} + G" (lib.generators.mkLuaInline "hl.dsp.layout('togglesplit')")];}
        # Move/resize window with mainMod + keys
        {_args = ["${mainMod} + SHIFT + L" (lib.generators.mkLuaInline "hl.dsp.window.swap({direction='r'})")];}
        {_args = ["${mainMod} + SHIFT + H" (lib.generators.mkLuaInline "hl.dsp.window.swap({direction='l'})")];}
        {_args = ["${mainMod} + SHIFT + J" (lib.generators.mkLuaInline "hl.dsp.window.swap({direction='d'})")];}
        {_args = ["${mainMod} + SHIFT + K" (lib.generators.mkLuaInline "hl.dsp.window.swap({direction='u'})")];}
        {_args = ["${mainMod} + CTRL + L" (lib.generators.mkLuaInline "hl.dsp.window.resize({x=50,y=0,relative=true})") (lib.generators.mkLuaInline "{repeating=true}")];}
        {_args = ["${mainMod} + CTRL + H" (lib.generators.mkLuaInline "hl.dsp.window.resize({x=-50,y=0,relative=true})") (lib.generators.mkLuaInline "{repeating=true}")];}
        {_args = ["${mainMod} + CTRL + J" (lib.generators.mkLuaInline "hl.dsp.window.resize({x=0,y=50,relative=true})") (lib.generators.mkLuaInline "{repeating=true}")];}
        {_args = ["${mainMod} + CTRL + K" (lib.generators.mkLuaInline "hl.dsp.window.resize({x=0,y=-50,relative=true})") (lib.generators.mkLuaInline "{repeating=true}")];}
        {_args = ["${mainMod} + F" (lib.generators.mkLuaInline "hl.dsp.window.fullscreen({mode='fullscreen',action='toggle'})")];}
        {_args = ["${mainMod} + SHIFT + F" (lib.generators.mkLuaInline "hl.dsp.window.fullscreen({mode='maximized',action='toggle'})")];}
        # Move focus with mainMod + arrow keys
        {_args = ["${mainMod} + L" (lib.generators.mkLuaInline "hl.dsp.focus({direction='r'})")];}
        {_args = ["${mainMod} + H" (lib.generators.mkLuaInline "hl.dsp.focus({direction='l'})")];}
        {_args = ["${mainMod} + J" (lib.generators.mkLuaInline "hl.dsp.focus({direction='d'})")];}
        {_args = ["${mainMod} + K" (lib.generators.mkLuaInline "hl.dsp.focus({direction='u'})")];}
        # Example special workspace (scratchpad)
        {_args = ["${mainMod} + grave" (lib.generators.mkLuaInline "hl.dsp.workspace.toggle_special('scratchpad')")];}
        {_args = ["${mainMod} + SHIFT + grave" (lib.generators.mkLuaInline "hl.dsp.window.move({workspace='special:scratchpad',follow=true})")];}
        # Lock with super-L
        {_args = ["${mainMod} + L" (lib.generators.mkLuaInline "hl.dsp.exec_cmd('hyprlock')") (lib.generators.mkLuaInline "{locked=true}")];}
        # Lock on lid close
        {_args = ["switch:Lid Switch" (lib.generators.mkLuaInline "hl.dsp.exec_cmd('hyprlock')") (lib.generators.mkLuaInline "{locked=true}")];}
        # Volume keys
        {_args = ["XF86AudioRaiseVolume" (lib.generators.mkLuaInline "hl.dsp.exec_cmd('wpctl set-volume @DEFAULT_AUDIO_SINK@ 10%+')") (lib.generators.mkLuaInline "{repeating=true,locked=true}")];}
        {_args = ["XF86AudioLowerVolume" (lib.generators.mkLuaInline "hl.dsp.exec_cmd('wpctl set-volume @DEFAULT_AUDIO_SINK@ 10%-')") (lib.generators.mkLuaInline "{repeating=true,locked=true}")];}
        # Backlight
        {_args = ["XF86MonBrightnessUp" (lib.generators.mkLuaInline "hl.dsp.exec_cmd('brightnessctl set 5%+')") (lib.generators.mkLuaInline "{repeating=true,locked=true}")];}
        {_args = ["XF86MonBrightnessDown" (lib.generators.mkLuaInline "hl.dsp.exec_cmd('brightnessctl set 5%-')") (lib.generators.mkLuaInline "{repeating=true,locked=true}")];}
        # Mute key
        {_args = ["XF86AudioMute" (lib.generators.mkLuaInline "hl.dsp.exec_cmd('wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle')") (lib.generators.mkLuaInline "{locked=true}")];}
      ];

      window_rule = [
        {
          name = "screensaver kitty window";
          match.title = "^(kitty-full)$";
          fullscreen = true;
        }
        {
          name = "floating kitty window";
          match.title = "^(kitty-float)$";
          float = true;
          center = true;
          size = "1024 768";
        }
      ];
    };
  };
}
