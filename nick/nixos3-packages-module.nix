{pkgs, ...}: {
  home.packages = with pkgs; [
    arduino-cli
    easyeffects
    cava
    yazi
    obsidian
    discord
  ];
}
