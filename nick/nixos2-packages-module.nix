{pkgs, ...}: {
  home.packages = with pkgs; [
    warpd
    cava
    yazi
    obsidian
    discord
    llama-cpp
    cmatrix
  ];
}
