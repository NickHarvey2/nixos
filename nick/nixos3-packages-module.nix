{pkgs, ...}: {
  home.packages = with pkgs; [
    arduino-cli
    easyeffects
    cava
    obsidian
    discord
  ];
}
