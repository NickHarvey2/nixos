{pkgs}: {
  enable = true;
  font = {
    package = pkgs.jetbrains-mono;
    name = "JetBrainsMono Nerd Font";
  };
  themeFile = "OneHalfDark";
  extraConfig = ''
    background_opacity         0.8
    dynamic_background_opacity yes
  '';
}
