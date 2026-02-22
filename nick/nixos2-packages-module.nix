{
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    cava
    yazi
    obsidian
    discord
    llama-cpp
  ];
}
