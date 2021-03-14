{ pkgs ? import <nixpkgs> { } }:
let
  fhs = pkgs.buildFHSUserEnv {
    name = "jupyter-lab-fhs";
    targetPkgs = pkgs: with pkgs;
      [
        python3Packages.jupyterlab
      ];
    runScript = "bash";
    profile = with pkgs; ''
      export PATH=${pkgs.python3Packages.jupyterlab}/bin:$PATH
    '';
  };
in
pkgs.stdenv.mkDerivation {
  name = "jupyter-lab-fhs-derivation";
  nativeBuildInputs = [ fhs ];
  src = builtins.path { path = ./.; };
  installPhase = ''
    mkdir --mode=0755 --parent $out/bin
    cp -r ${fhs}/bin "$out"
  '';
  shellHook = ''
    exec -c jupyter-lab-fhs
  '';
}
