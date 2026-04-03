{pkgs, ...}: {
  home.packages = with pkgs; [
    easyeffects
    cava
    yazi
    obsidian
    discord
  ];
}
