{pkgs}: {
  enable = true;
  enableSshSupport = true;
  enableZshIntegration = true;
  enableScDaemon = true;
  verbose = true;
  pinentryPackage = pkgs.pinentry-curses;
  grabKeyboardAndMouse = false;
  sshKeys = [ "68AE6DA7F0EAB9BC" ];
}
