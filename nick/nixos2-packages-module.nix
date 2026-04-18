{pkgs, ...}: {
  home.packages = with pkgs; [
    cava
    yazi
    obsidian
    discord
    cmatrix
    bambu-studio
    openscad
  ];
}
