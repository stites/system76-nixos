{ lib, callPackage }:

let
  generic = args: callPackage (import ./generic.nix args) { };
in

rec {
  beta = generic {
    version = "1.0.4";
    sha = "03fm40gf9962jcwb4yj90pa2269nlbg1w2wpwaa8j2kq9263fkh2";
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
