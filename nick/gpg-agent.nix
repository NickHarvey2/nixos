{pkgs}: {
  enable = true;
  enableSshSupport = true;
  enableZshIntegration = true;
  verbose = true;
  pinentry.package = pkgs.pinentry-curses;
  grabKeyboardAndMouse = false;
}
