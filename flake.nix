{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          overlays = [ (final: prev: {
            python3Packages.numpy = prev.python3Packages.numpy.overrideAttrs (old: { mesonFlags = (old.mesonFlags or []) ++ [
              "-Dcpu-baseline=native"
              "-Dcpu-dispatch=none"
            ];}); 
          }) ];
          pkgs = import nixpkgs {
            inherit system overlays;
          };
        in
        with pkgs;
        {
          devShells.default = mkShell {
            buildInputs = [ python3 python3Packages.numpy ];
          };
        }
      );
}
