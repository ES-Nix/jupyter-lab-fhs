{ pkgs ? import <nixpkgs> { } }:
let
  fhs = pkgs.buildFHSUserEnv {
    name = "julia-fhs";
    targetPkgs = pkgs: with pkgs;
      [
        julia
      ];
    runScript = "bash";
  };
in
pkgs.stdenv.mkDerivation {
  name = "julia-fhs-derivation";
  nativeBuildInputs = [ fhs ];
  src = builtins.path { path = ./.; };
  installPhase = ''
    mkdir --mode=0755 --parent $out/bin
    cp -r ${fhs}/bin "$out"
  '';
  shellHook = ''
    exec -c julia-fhs
  '';
}
