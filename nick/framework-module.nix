{pkgs, ...}: {
  home.packages = with pkgs; [
    fw-ectool
    framework-tool
    framework-tool-tui
  ];
}
