{ latest ? false }: { config, pkgs, ... }:

{
  boot.kernelPackages = if latest then pkgs.linuxPackages_latest else pkgs.linuxPackages;

  # This is required for system76-driver, I believe. Can I just add this to the nix script?
  boot.kernelParams = [ "ec_sys.write_support=1" ];

  # Imports the overlay
  nixpkgs.overlays = [
    (self: super: {
      linuxPackages_latest = super.linuxPackages_latest.extend(lpself: lpsuper: {
        system76-dkms = (lpself.callPackage ./system76-dkms {}).stable;
      });
      linuxPackages = super.linuxPackages.extend(lpself: lpsuper: {
        system76-dkms = (lpself.callPackage ./system76-dkms {}).stable;
      });
    })
  ];

  boot.extraModulePackages = [ (if latest then pkgs.linuxPackages_latest else pkgs.linuxPackages).system76-dkms ];

  # This line I think is not needed. Depends on when I'm supposed to load this
  # boot.kernelModules = [ "system76" ];
}
