{version, rev, sha, cargoSha}:
{ stdenv, fetchFromGitHub, fetchpatch, kernel
, rustPlatform, cargo, cargo-vendor
, dbus, systemd, libsodium, pkgconfig, lzma, openssl, gnumake, gcc, binutils, git
}:

rustPlatform.buildRustPackage {
  name = "system76-firmware-${version}";
  version = "${version}";

  src = fetchFromGitHub {
      owner = "pop-os";
      repo = "system76-firmware";
      rev = "${rev}";
      sha256 = "${sha}";
    };

  enableParallelBuilding = true;

  # FIXME: not sure what this does... can someone spotcheck this?
  hardeningDisable = [ "pic" ];

  nativeBuildInputs = kernel.moduleBuildDependencies ++ [
    dbus systemd libsodium pkgconfig lzma openssl gnumake gcc binutils
    cargo cargo-vendor git
  ];

  buildInputs = [ cargo cargo-vendor git ];

  cargoSha256 = "${cargoSha}";

  outputs = [ "out" ];

  ################################################################################################
  # The only recent changes since 1.0.2 seem to be changing the cli binary from
  # `system-firmware` to `system-firmware-cli` and installing the system daemon.
  ################################################################################################
  installPhase = let
    # Keep this in line with the Makefile?
    sysconfdir = "/etc";
    PKG = "system76-firmware";
    CLI = "${PKG}";
    CLI_OUTPUT = "${CLI}-cli";
    DAEMON = "${PKG}-daemon";
  in ''
    mkdir $out

    # From Makefile 'install-cli'
    mkdir -p $out/bin/
    install -D -m 0755 "target/release/${CLI}" "$out/bin/${CLI_OUTPUT}"

    # From Makefile 'install-daemon'
    mkdir -p $out/lib/${PKG}
    install -D -m 0755 "target/release/${DAEMON}" "$out/lib/${PKG}/${DAEMON}"
    mkdir -p $out/etc/dbus-1/system.d/
    install -D -m 0644 "data/${DAEMON}.conf" "$out/etc/dbus-1/system.d/${DAEMON}.conf"
    mkdir -p $out/etc/systemd/system/
    install -D -m 0644 "debian/${DAEMON}.service" "$out/etc/systemd/system/${DAEMON}.service"
  '';

  meta = with stdenv.lib; {
    maintainers = [ maintainers.stites ];
    platforms = [ "i686-linux" "x86_64-linux" ];
    description = "System76 Firmware Tool and Daemon";
    homepage = https://github.com/pop-os/system76-firmware;
    longDescription = ''
      The system76-firmware package has a CLI tool for installing firmware updates.
      Also included is the system76-firmware-daemon package, which has a systemd service
      that exposes a DBUS API for handling firmware updates.
    '';
  };
}
