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

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    enableZshIntegration = true;
    verbose = true;
    pinentry.package = pkgs.myPinentryPackage;
    grabKeyboardAndMouse = false;
  };
}
