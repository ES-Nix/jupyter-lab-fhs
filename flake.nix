{
  description = "A usefull description";

  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgsAllowUnfree = import nixpkgs {
          system = "x86_64-linux";
          config = { allowUnfree = true; };
        };
      in
      {
        packages.julia-fhs = import ./julia-fhs.nix {
          pkgs = pkgsAllowUnfree;
        };

        defaultPackage = self.packages.${system}.julia-fhs;
      }
    );
}
