{ config, lib, pkgs, ... }:

let
  cfg = config.hardware.system76;

  # Supported laptop models.  Models for which the generic configuration isn't
  # specific can be added here.
  supportedModels = [ "generic" "darp6" ];

  # darp6 needs system76-acpi-dkms, not system76-dkms:
  #
  # [1] https://github.com/pop-os/system76-dkms/issues/39
  # jackpot51> system76-acpi-dkms is the correct driver to use on the darp6
  #
  # system76-io-dkms also appears to be loaded on darp6 with Pop!_OS, and
  # system76-dkms does not.

  useAcpiDkms = builtins.elem cfg.model [ "darp6" ];

  useIoDkms = builtins.elem cfg.model [ "darp6" ];

  # In absense of more knowledge, we install system76-dkms for all other models.
  useDkms = !builtins.elem cfg.model [ "darp6" ];

  kernelPackages = let inherit (config.boot.kernelPackages) callPackage; in {
    system76-acpi-dkms = (callPackage ./system76-acpi-dkms {}).${cfg.release};
    system76-io-dkms = (callPackage ./system76-io-dkms {}).${cfg.release};
    system76-dkms = (callPackage ./system76-dkms {}).${cfg.release};
  };
in
{
  options.hardware.system76 = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      example = true;
      description = ''
        Whether to enable support for System76 hardware.
      '';
    };

    model = lib.mkOption {
      type = lib.types.enum supportedModels;
      default = "generic";
      description = ''
        The model of System76 laptop to configure for.  This determines which
        kernel drivers will be used.  If there is no specific support for your
        model, a generic configuration may be used.
      '';
    };

    release = lib.mkOption {
      type = lib.types.enum [ "beta" "stable" ];
      default = "stable";
      example = "beta";
      description = ''
        Whether to use stable or beta versions of System76 software releases.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    # This is required for system76-driver, I believe. Can I just add this to the nix script?
    boot.kernelParams = [ "ec_sys.write_support=1" ];

    boot.extraModulePackages =
      lib.optional useAcpiDkms kernelPackages.system76-acpi-dkms ++
      lib.optional useIoDkms kernelPackages.system76-io-dkms ++
      lib.optional useDkms kernelPackages.system76-dkms;

    # system76_acpi automatically loads on darp6, but system76_io does not.
    # Explicitly load both for consistency.
    boot.kernelModules =
      lib.optional useAcpiDkms "system76_acpi" ++
      lib.optional useIoDkms "system76_io" ++
      # This line I think is not needed. Depends on when I'm supposed to load this
      [];  # lib.optional useDkms "system76"
  };
}
