{
  description = "iso639-lang: Python ISO-639 language code library exposing the `Lang` class used by LazyLibrarian.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pin = import ./pin.nix;
        inherit (pin) version hash;
        pkgs = import nixpkgs { inherit system; };
        iso639-lang = pkgs.python3Packages.buildPythonPackage {
          pname = "iso639-lang";
          inherit version;
          pyproject = true;
          # PyPI distribution name uses an underscore (`iso639_lang`); Nix uses a dash by convention.
          src = pkgs.python3Packages.fetchPypi {
            pname = "iso639_lang";
            inherit version hash;
          };
          build-system = [ pkgs.python3Packages.setuptools ];
          doCheck = false;
        };
        update-version = pkgs.writeShellApplication {
          name = "update-version";
          text = ''exec ${./update-version.sh} "$@"'';
        };
        update-branches = pkgs.writeShellApplication {
          name = "update-branches";
          text = ''exec ${./update-branches.sh} "$@"'';
        };
      in
      {
        packages = {
          inherit iso639-lang update-version update-branches;
          default = iso639-lang;
        };
      });
}
