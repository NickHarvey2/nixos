{
  pkgs,
  ...
}: {
  programs.gpg = {
    enable = true;
    # disable ccid on scdaemon so it doesn't conflict with pcscd
    scdaemonSettings.disable-ccid = true;
    publicKeys = [
      {
        source = ./public_key;
        trust = 5;
      }
    ];
  };

  home.file.commonConf = {
    # By default this file is created with keyboxd set to be enabled
    # So create an empty file to prevent this
    target = ".gnupg/common.conf";
    text = "";
  };

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    enableZshIntegration = true;
    verbose = true;
    pinentry.package = pkgs.myPinentryPackage;
    grabKeyboardAndMouse = false;
  };
}
