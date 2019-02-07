{ config, pkgs, ... }:

{
  # boot.kernelPackages = pkgs.linuxPackages_4_18;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # This is required for system76-driver, I believe. Can I just add this to the nix script?
  boot.kernelParams = [ "ec_sys.write_support=1" ];

  # Imports the overlay
  nixpkgs.overlays = [
    (self: super: {
      linuxPackages_latest = super.linuxPackages_latest.extend(lpself: lpsuper: {
        system76-dkms = (lpself.callPackage ./system76-dkms {}).stable;
      });
    })
  ];

  boot.extraModulePackages = [ pkgs.linuxPackages_latest.system76-dkms ];

  # This line I think is not needed. Depends on when I'm supposed to load this
  # boot.kernelModules = [ "system76" ];
}
