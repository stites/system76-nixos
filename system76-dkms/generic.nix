{version, sha}: { stdenv, fetchFromGitHub, fetchpatch, kernel }:

stdenv.mkDerivation {
  name = "system76-dkms-${version}";
  version = "${version}";

  src = fetchFromGitHub {
      owner = "pop-os";
      repo = "system76-dkms";
      rev = "${version}";
      sha256 = "${sha}";
    };

  hardeningDisable = [ "pic" ];
  dontStrip = true;
  dontPatchELF = true;

  kernel = kernel.dev;
  nativeBuildInputs = kernel.moduleBuildDependencies;

  preBuild = ''
    sed -e "s@/lib/modules/\$(.*)@${kernel.dev}/lib/modules/${kernel.modDirVersion}@" -i Makefile
  '';

  outputs = [ "out" ];
  installPhase = ''
    mkdir -p $out/lib/modules/${kernel.modDirVersion}/misc
    cp system76.ko $out/lib/modules/${kernel.modDirVersion}/misc

    # not sure if these are working
    mkdir -p $out/usr/share/initramfs-tools/hooks
    cp {$src,$out}/usr/share/initramfs-tools/hooks/system76-dkms

    mkdir -p $out/usr/share/initramfs-tools/modules.d
    cp {$src,$out}/usr/share/initramfs-tools/modules.d/system76-dkms.conf
  '';

  meta = with stdenv.lib; {
    maintainers = [ maintainers.stites ];
    platforms = [ "i686-linux" "x86_64-linux" ];
    description = "System76 DKMS driver";
    homepage = https://github.com/pop-os/system76-dkms;
    longDescription = ''
      The System76 DKMS driver. On newer System76 laptops, this driver controls some of the hotkeys and allows for custom fan control.
    '';
  };
}
