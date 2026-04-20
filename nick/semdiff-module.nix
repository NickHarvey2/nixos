{
  inputs,
  pkgs,
  ...
}: let
  semPkg = inputs.semdiff.packages.${pkgs.stdenv.hostPlatform.system}.default;
  semdiff = pkgs.symlinkJoin {
    name = "semdiff";
    paths = [ semPkg ];
    nativeBuildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      rm -f $out/bin/sem
      makeWrapper ${semPkg}/bin/sem $out/bin/semdiff
    '';
  };
in {
  home.packages = [
    semdiff
  ];
}
