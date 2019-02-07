let
  config = {
    # allowUnfree = true;
    packageOverrides = pkgs: {
      linuxPackages = pkgs.linuxPackages.extend(self: super: {
        system76-dkms = self.callPackage ./system76-dkms {};
      });
    };
  };

      # linuxPackages_latest = super.linuxPackages_latest.extend(lpself: lpsuper: {
      #   system76-dkms = (lpself.callPackage ./system76-dkms {}).stable;
      # });
  pkgs = import ((import <nixpkgs> {}).fetchFromGitHub {
    owner  = "NixOS";
    repo   = "nixpkgs-channels";
    rev    = "2d6f84c1090ae39c58dcec8f35a3ca62a43ad38c";
    sha256 = "0l8b51lwxlqc3h6gy59mbz8bsvgc0q6b3gf7p3ib1icvpmwqm773";
  }) { inherit config; };

in with pkgs; {
  system76-dkms_beta         = linuxPackages.system76-dkms.beta;
  system76-dkms_stable       = linuxPackages.system76-dkms.stable;
  system76-dkms_legacy_1_0_1 = linuxPackages.system76-dkms.legacy_1_0_1;
  system76-dkms_legacy_1_0_0 = linuxPackages.system76-dkms.legacy_1_0_0;
}
