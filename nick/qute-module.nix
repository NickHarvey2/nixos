{
  inputs,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    python314Packages.adblock
  ];

  home.file.quteCatppuccin = {
    target = ".config/qutebrowser/catppuccin";
    source = inputs.qute-catppuccin;
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "org.qutebrowser.qutebrowser.desktop";
      "x-scheme-handler/http" = "org.qutebrowser.qutebrowser.desktop";
      "x-scheme-handler/https" = "org.qutebrowser.qutebrowser.desktop";
      "x-scheme-handler/about" = "org.qutebrowser.qutebrowser.desktop";
      "x-scheme-handler/unknown" = "org.qutebrowser.qutebrowser.desktop";
    };
  };

  programs.qutebrowser = {
    enable = true;
    searchEngines = {
      w = "https://en.wikipedia.org/wiki/Special:Search?search={}&go=Go&ns0=1";
      aw = "https://wiki.archlinux.org/?search={}";
      nw = "https://wiki.nixos.org/w/index.php?search={}";
      np = "https://search.nixos.org/packages?type=packages&query={}";
      no = "https://search.nixos.org/options?type=packages&query={}";
      DEFAULT = "https://kagi.com/search?q={}";
      k = "https://kagi.com/search?q={}";
    };
    settings = {
      content = {
        desktop_capture = false;
        geolocation = false;
        register_protocol_handler = false;
        tls.certificate_errors = "block";
        notifications.enabled = false;
      };
      fonts.default_family = "JetBrainsMono";
      tabs = {
        position = "left";
        width = "10%";
        title.format = "{index}: {audio}{current_title}";
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

        # override catppuccin colors for selected tab
        config.set('colors.tabs.selected.even.bg', config.get('colors.tabs.pinned.even.bg'))
        config.set('colors.tabs.selected.odd.bg', config.get('colors.tabs.pinned.odd.bg'))
        config.set('colors.tabs.selected.even.fg', 'black')
        config.set('colors.tabs.selected.odd.fg', 'black')

        from qutebrowser.api import message
        try:
            from qutebrowser.mainwindow import tabwidget
            tabwidget.TabWidget.MUTE_STRING = "󰖁 "
            tabwidget.TabWidget.AUDIBLE_STRING = "󰕾 "
        except (ImportError, AttributeError) as err:
            message.error(f"Failed to change audio indicators {err}")
      '';
    quickmarks = {
      "Finance Ameren" = "https://www.ameren.com/";
      "Finance American Express" = "https://www.americanexpress.com/en-us/account/login?inav=iNavLnkLog";
      "Finance Central Bank" = "https://www.centralbank.net/";
      "Finance MetLife" = "https://www.eaccountservices.com/metlife";
      "Finance Fidelity" = "https://login.fidelity.com/ftgw/Fidelity/RtlCust/Login/Init/df.chf.ra/ePrefill";
      "Finance Sheet" = "https://docs.google.com/spreadsheets/d/1AjURtH4r9WohLQkHlyr1KrHhYh_bKlRUnzZG9fe1bTs/edit#gid=1030079569";
      "Finance Janus Henderson" = "https://www.secureaccountview.com/BFWeb/clients/janushenderson/index?do=logOut";
      "Finance Milliman" = "https://login.millimanonline.com/Logon?";
      "Finance Chase" = "https://secure03a.chase.com/web/auth/dashboard#/dashboard/overviewAccounts/overview/index";
      "Finance UMB" = "https://securebanking.umb.com/umb/uux.aspx#/account/2647527?currentTab=transactions&tectonRoute=&tectonState=";
      "Nix Home-Manager Configuration Options" = "https://nix-community.github.io/home-manager/options.xhtml";
      "Nix Home-Manager Manual" = "https://nix-community.github.io/home-manager/index.xhtml";
      "Nix NixOS-WSL" = "https://nix-community.github.io/NixOS-WSL/";
      "Nix nvim-lspconfig server configurations" = "https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.txt";
      "CenturyLink Modem Configuration" = "http://192.168.0.1/#";
      "Brightspeed" = "https://myaccount.brightspeed.com/help-and-support";
      "Dig" = "https://toolbox.googleapps.com/apps/dig/#A/%s";
      "GitHub CLI" = "https://cli.github.com/manual/gh_config";
      "kubectl Cheat Sheet" = "https://kubernetes.io/docs/reference/kubectl/cheatsheet/";
      "Messages" = "https://messages.google.com/web/conversations/16";
      "NETGEAR Router R7000P" = "http://192.168.0.37/";
      "Raindrop" = "https://app.raindrop.io/";
      "regex101: build, test, and debug regex" = "https://regex101.com/";
      "Twitch" = "https://www.twitch.tv/";
      "Cypher Abilities" = "https://callmepartario.github.io/og-csrd/#chapter-9-abilities";
      "Cypher Adept" = "https://callmepartario.github.io/og-csrd/#type-adept";
      "Cypher Advancement" = "https://callmepartario.github.io/og-csrd/#character-advancement";
      "Cypher Armor" = "https://callmepartario.github.io/og-csrd/#equipment-armor";
      "Cypher Decriptors" = "https://callmepartario.github.io/og-csrd/#chapter-7-descriptor";
      "Cypher Explorer" = "https://callmepartario.github.io/og-csrd/#type-explorer";
      "Cypher Flavor" = "https://callmepartario.github.io/og-csrd/#chapter-6-flavor";
      "Cypher Foci" = "https://callmepartario.github.io/og-csrd/#chapter-8-focus";
      "Cypher Speaker" = "https://callmepartario.github.io/og-csrd/#type-speaker";
      "Cypher Warrior" = "https://callmepartario.github.io/og-csrd/#type-warrior";
      "Cypher Weapons" = "https://callmepartario.github.io/og-csrd/#equipment-weapons";
      "Hyprland Hyprctl" = "https://wiki.hypr.land/Configuring/Using-hyprctl/";
      "Hyprland Wiki" = "https://wiki.hypr.land/";
      "Qmk Docs" = "https://docs.qmk.fm/";
      "Captive Portal Login" = "http://http.badssl.com/";
      "gmail" = "https://mail.google.com";
      "gridfinity" = "https://gridfinitygenerator.com";
    };
  };
}
