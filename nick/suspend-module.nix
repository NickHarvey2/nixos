{
  services.hypridle.settings.listener = [
    {
      timeout = 1800;
      on-timeout = "systemctl suspend";
    }
  ];
}
