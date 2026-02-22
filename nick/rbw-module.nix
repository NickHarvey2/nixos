{
  pkgs,
  ...
}: {
  programs.rbw = {
    enable = true;
    settings = {
      email = "nmhdh8@gmail.com";
      pinentry = pkgs.myPinentryPackage;
    };
  };
}
