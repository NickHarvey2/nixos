{pkgs, ...}: {
  home.packages = with pkgs; [
    cava
    obsidian
    discord
  ];
}
