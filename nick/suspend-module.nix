{
  services.hypridle.settings.listener = [
    {
      timeout = 1800;
      on-timeout = "systemctl suspend";
    }

    {
      timeout = 150;
      on-timeout = "brightnessctl -s set 5";
      on-resume = "brightnessctl -r";
    }

    {
      timeout = 300;
      on-timeout = "loginctl lock-session";
    }

    {
      timeout = 330;
      on-timeout = "hyprctl dispatch dpms off";
      on-resume = "hyprctl dispatch dpms on";
    }
  ];
}
