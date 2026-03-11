{
  services.hypridle.settings.listener = [
    {
      timeout = 300;
      on-timeout = "pidof cmatrix || kitty --title kitty-full -o font_size=24 -o background_opacity=0.95 -o background=black -- cmatrix -sb";
    }
  ];
}
