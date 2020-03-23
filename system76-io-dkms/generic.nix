{version, rev ? version, sha}: { stdenv, fetchFromGitHub, fetchpatch, kernel }:

stdenv.mkDerivation {
  name = "system76-io-dkms-${version}";
  version = "${version}";

  src = fetchFromGitHub {
      owner = "pop-os";
      repo = "system76-io-dkms";
      inherit rev;
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
    cp system76-io.ko $out/lib/modules/${kernel.modDirVersion}/misc

    # not sure if these are working
    mkdir -p $out/usr/share/initramfs-tools/hooks
    cp {$src,$out}/usr/share/initramfs-tools/hooks/system76-io-dkms

    mkdir -p $out/usr/share/initramfs-tools/modules.d
    cp {$src,$out}/usr/share/initramfs-tools/modules.d/system76-io-dkms.conf
  '';

  meta = with stdenv.lib; {
    maintainers = [ maintainers.khumba ];
    platforms = [ "i686-linux" "x86_64-linux" ];
    description = "DKMS module for controlling System76 Io board";
    homepage = https://github.com/pop-os/system76-io-dkms;
  };
}
