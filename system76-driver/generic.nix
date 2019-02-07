{ version, sha }:
{ stdenv, fetchFromGitHub, fetchpatch, kernel
, python3Packages, python3 # pygobject3
, dbus, systemd, gnome3, gobjectIntrospection, pango, pkgconfig, gcc #, lzma, openssl, gnumake, binutils, git
}:
let
  pversion = version;
in
python3Packages.buildPythonPackage rec {
  pname = "system76-driver-${version}";
  version = "${pversion}";

  src = fetchFromGitHub {
    owner = "pop-os";
    repo = "system76-driver";
    rev = "${version}";
    sha256 = "${sha}";
  };

  nativeBuildInputs = kernel.moduleBuildDependencies ++ [ gobjectIntrospection systemd pango gnome3.gdk_pixbuf gnome3.gtk3 pkgconfig python3 ];

  pythonPath = with python3Packages; [ pygobject3 dbus ];
  propogatedBuildInputs = pythonPath;

  enableParallelBuilding = true;
  doCheck = false;
  outputs = [ "out" ];

  meta = with stdenv.lib; {
    maintainers = [ maintainers.stites ];
    platforms = [ "i686-linux" "x86_64-linux" ];
    description = "System76 Driver";
    homepage = https://github.com/pop-os/system76-driver;
    longDescription = ''
      This program installs drivers and provides restore functionality for System76 machines
    '';
  };
}

