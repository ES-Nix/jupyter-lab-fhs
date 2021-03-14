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
        packages.jupyter-lab-fhs = import ./jupyter-lab-fhs.nix {
          pkgs = pkgsAllowUnfree;
        };

        defaultPackage = self.packages.${system}.jupyter-lab-fhs;
      }
    );
}
