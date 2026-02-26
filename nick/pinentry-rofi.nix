{pkgs, ...}: {
  nixpkgs.overlays = [
    (final: prev: {
      myPinentryPackage = pkgs.pinentry-rofi;
    })
  ];
}
