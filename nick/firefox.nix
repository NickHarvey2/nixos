{
  inputs,
  pkgs,
}: {
  enable = true;
  policies = {
    BlockAboutConfig = false;
    DefaultDownloadDirectory = "\${home}/Downloads";
  };
  profiles.nick = {
    isDefault = true;
    containers = {
      # "dangerous" = {
      #   color = "red";
      #   icon = "fruit";
      #   id = 1;
      # };
    };
    containersForce = true;
    settings = {
      "distribution.searchplugins.defaultLocale" = "en-US";
      "dom.security.https_only_mode" = true;
      "signon.rememberSignons" = false;
      "browser.tabs.loadBookmarksInTabs" = false;
      "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      "browser.tabs.drawInTitlebar" = false;
      "browser.tabs.inTitlebar" = false;
      "browser.aboutConfig.showWarning" = false;
      "browser.ctrlTab.sortByRecentlyUsed" = true;
      "browser.gesture.pinch.in" = "";
      "browser.gesture.pinch.in.shift" = "";
      "browser.gesture.pinch.out" = "";
      "browser.gesture.pinch.out.shift" = "";
      "browser.gesture.swipe.down" = "";
      "browser.gesture.swipe.up" = "";
      "browser.gesture.swipe.left" = "";
      "browser.gesture.swipe.right" = "";
      "browser.gesture.tap" = "";
      "browser.gesture.twist.end" = "";
      "browser.gesture.twist.left" = "";
      "browser.gesture.twist.right" = "";
      "services.sync.username" = "nmhdh8@gmail.com";
      "browser.urlbar.suggest.quicksuggest.sponsored" = false;
      "browser.urlbar.suggest.quicksuggest.nonsponsored" = false;
      "privacy.resistFingerprinting" = true;
      "privacy.resistFingerprinting.pbMode" = true;
      "permissions.default.shortcuts" = 2;
    };
    search = {
      default = "kagi";
      force = true;
      order = [
        "kagi"
        "ddg"
        "google"
      ];
      engines = {
        kagi = {
          name = "Kagi";
          urls = [
            {
              template = "https://kagi.com/search";
              params = [
                {
                  name = "q";
                  value = "{searchTerms}";
                }
              ];
            }
          ];
          # TODO put this in LFS
          icon = "moz-extension://aeadf771-aa9a-42ff-8526-a3da8164e922/icons/icon_16px.png";
          definedAliases = ["@k"];
        };
        Nix-packages = {
          name = "Nix Packages";
          urls = [
            {
              template = "https://search.nixos.org/packages";
              params = [
                {
                  name = "type";
                  value = "packages";
                }
                {
                  name = "query";
                  value = "{searchTerms}";
                }
              ];
            }
          ];
          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = ["@np"];
        };
      };
    };
    extensions.packages = with inputs.firefox-addons.packages."x86_64-linux"; [
      bitwarden
      sidebery
      vimium
      private-relay
      clearurls
      multi-account-containers
      kagi-search
      tabliss
    ];
    userChrome = builtins.readFile ./userChrome.css;
  };
}
