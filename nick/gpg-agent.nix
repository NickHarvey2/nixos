{pkgs}: {
  enable = true;
  enableSshSupport = true;
  enableZshIntegration = true;
  verbose = true;
  pinentryPackage = pkgs.pinentry-curses;
  grabKeyboardAndMouse = false;
}
