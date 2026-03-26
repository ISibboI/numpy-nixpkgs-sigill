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
            python314Packages.numpy = prev.python314Packages.numpy.overrideAttrs (old: { mesonFlags = (old.mesonFlags or []) ++ [
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
            buildInputs = [ python314 python314Packages.numpy ];
          };
        }
      );
}
