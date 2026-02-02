{
  enable = true;
  settings = {
    content = {
      desktop_capture = false;
      geolocation = false;
      register_protocol_handler = false;
    };
    fonts.default_family = "JetBrainsMono";
    tabs = {
      position = "left";
      width = "10%";
    };
    auto_save.session = true;
    colors = {
      webpage = {
        darkmode.enabled = true;
        preferred_color_scheme = "dark";
      };
      tabs = {
        indicator = {
          stop = "#008800";
          start = "#000088";
        };
      };
    };
  };
  perDomainSettings = {
    "https://*.google.com/*".content.headers.user_agent = "Mozilla/5.0 ({os_info}; rv:130.0) Gecko/20100101 Firefox/130";
    "https://*.google.com/*".colors.webpage.darkmode.enabled = false;
    "https://*.google.com/*".content.notifications.enabled = true;
  };
  keyBindings = {
    normal = {
      "sm" = "cmd-set-text -s :set-mark";
      "jm" = "cmd-set-text -s :jump-mark";
    };
  };
  extraConfig =
  # py
  ''
    import catppuccin
    catppuccin.setup(c, 'macchiato', True)
  '';
}
