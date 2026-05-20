{pkgs, ...}: {
  home.packages = with pkgs; [
    android-tools
    libarchive
    cava
    obsidian
    discord
    cmatrix
    bambu-studio
    openscad
    transmission_4
  ];
}
