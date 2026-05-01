{
  programs.firefox = {
    enable = true;
    configPath = ".mozilla/firefox";
    policies = {
      BlockAboutConfig = false;
      DefaultDownloadDirectory = "\${home}/Downloads";
    };
    profiles.nick = {
      isDefault = true;
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
        "browser.ml.enable" = false;
        "browser.ml.chat.enabled" = false;
        "browser.ml.chat.hideFromLabs" = true;
        "browser.ml.chat.hideLabsShortcuts" = true;
        "browser.ml.chat.page" = false;
        "browser.ml.chat.page.footerBadge" = false;
        "browser.ml.chat.page.menuBadge" = false;
        "browser.ml.chat.menu" = false;
        "browser.ml.linkPreview.enabled" = false;
        "browser.ml.pageAssist.enabled" = false;
        "browser.tabs.groups.smart.enabled" = false;
        "browser.tabs.groups.smart.userEnable" = false;
        "extensions.ml.enabled" = false;
      };
    };
  };
}
