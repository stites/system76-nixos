{ lib, callPackage }:

let
  generic = args: callPackage (import ./generic.nix args) { };
in

rec {
  beta = stable;
  stable = generic {
    version = "1.0.1";
    sha = "0jmm9h607f7k20yassm6af9mh5l00yih5248wwv4i05bd68yw3p5";
  };
}
