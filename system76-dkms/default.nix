{ lib, callPackage }:

let
  generic = args: callPackage (import ./generic.nix args) { };
in

rec {
  beta = generic {
    version = "1.0.6";
    sha = "0263aqm0aibnfhy1m99nj36c7p2327a3aqk5by2nm2mjm3sqr5zc";
  };
  stable = generic {
    version = "1.0.3";
    sha = "0f6frbjjg8fap5n29j1khb5m5bbz36ycd9dzjrgs59bgkxmwfwmc";
  };
  # there is no 1_0_2
  legacy_1_0_1 = generic {
    version = "1.0.1";
    sha = "1lwbz8irjjnvqbajg5s6fm7jzvvs60ral7k7wma1q233nj3ajsja";
  };
  legacy_1_0_0 = generic {
    version = "1.0.0";
    sha = "1bjl6w5hnlprb1n3823g30wwfwxwq20bwr8lwj5sibcgyh1n443y";
  };
}
