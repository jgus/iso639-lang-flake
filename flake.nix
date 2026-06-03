{
  description = "iso639-lang: Python ISO-639 language code library exposing the `Lang` class used by LazyLibrarian.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    flake-lib = {
      url = "github:jgus/flake-lib/v1";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
  };

  outputs = { self, nixpkgs, flake-utils, flake-lib }:
    flake-lib.lib.mkLeafFlake {
      inherit nixpkgs flake-utils;
      # PyPI distribution name uses an underscore (`iso639_lang`); Nix uses a dash by convention.
      source = { type = "pypi"; pname = "iso639_lang"; format = "sdist"; };
      package = {
        attr = "iso639-lang";
        description = "iso639-lang: Python ISO-639 language code library exposing the `Lang` class used by LazyLibrarian.";
      };
      pin = import ./pin.nix;
    };
}
