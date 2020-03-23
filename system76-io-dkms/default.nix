{ lib, callPackage }:

let
  generic = args: callPackage (import ./generic.nix args) { };
in

rec {
  beta = stable;
  stable = generic {
    version = "1.0.1";
    sha = "0qkgkkjy1isv6ws6hrcal75dxjz98rpnvqbm7agdcc6yv0c17wwh";
  };
}
