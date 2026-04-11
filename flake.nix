{
  description = "Populate me!";
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/25.11;
  };

  outputs = { self, nixpkgs }@inputs: let
    forAllSystems = nixpkgs.lib.genAttrs nixpkgs.lib.systems.flakeExposed;
    overlays = [];
    pkgsFor = system: import nixpkgs { inherit overlays system; };
    packages = (pkgs: let

    in [
      pkgs.just
      pkgs.pandoc
    ]);
  in {

    devShells = forAllSystems (system: {
      default = (pkgsFor system).mkShell {
        buildInputs = (packages (pkgsFor system));
      };
    });
  };
}
