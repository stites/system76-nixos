{ pkgs, lib, callPackage }:

let
  python = pkgs.python36;
  python3Packages = pkgs.python36Packages;
   # 'python2.withPackages (ps: with ps; [ pygobject3 ])' --run "python -c \"import pygtkcompat; pygtkcompat.enable_gtk(version='3.0')\""
  python3 = python.withPackages (pkgs: with pkgs; [  ]);
  generic = args: callPackage (import ./generic.nix args) { inherit python3Packages python3; }; # inherit (python.pkgs) buildPythonPackage; inherit python3; };
in

rec {
  v19_04_3 = generic {
    version = "19.04.3";
    sha = "1pqb22zy3sx3k8qhvzw4g45wbg73g81qvyx7vgh4g8w5ar52nyxc";
  };
  v18_10_6 = generic {
    version = "18.10.6";
    sha = "12jgfd5mr0c25k299r6isfcbk6ydm8c26qglrfcdsnn4204hv2b2";
  };
  v18_04_35 = generic {
    version = "18.04.35";
    sha = "01abk0sv5gvf7sfsasd42m0m6abaim1fca8m5v1xgb6iaydh4kcp";
  };
}
