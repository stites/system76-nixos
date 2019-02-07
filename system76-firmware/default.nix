{ lib, callPackage }:

let
  generic = args: callPackage (import ./generic.nix args) { };
in

# {
#   ################################################################################################
#   # The only recent changes since 1.0.2 seem to be changing the cli binary from
#   # `system-firmware` to `system-firmware-cli` and installing the system daemon.
#   #
#   # 1.0.2 was released on 05/08/2018 -- today (02/06/2019), there have been the following commits:
#   # - SSL Fix (for debian, I believe)
#   # - Rename cli binary to have -cli suffix (reflected in our current build-scripts)
#   # - install/uninstall the systemd unit with the daemon (reflected in our current build-scripts)
#   # - Update error message to reflect action taken (can wait till next release)
#   # - Create ISSUE_TEMPLATE.md (not nessecary here)
#   #
#   ################################################################################################
#   # git = generic {
#   #   version = "git";
#   #   rev = "e2f80e879aac7cefa3d19884d308aa929a018e77";
#   #   sha = "0b0n13k0k3w0pbxhdzisag0kp399g1yp9iq99dyw70z3bla7zp7b";
#   #   cargoSha = "0i8yvvahaabhayvmg8l8wm7s6ib5rcarff8c7sazj6cgqcj6q6bn";
#   # };
#
#   stable = generic rec {
#     version = "1.0.2";
#     rev = version;
#     sha = "0xsjrrwibrn0rmfhvkbjfyvk8dhxy8jagzgvbw3i8d4ff57agysy";
#     cargoSha = "0i8yvvahaabhayvmg8l8wm7s6ib5rcarff8c7sazj6cgqcj6q6bn";
#   };
# }

generic rec {
  version = "1.0.2";
  rev = version;
  sha = "0xsjrrwibrn0rmfhvkbjfyvk8dhxy8jagzgvbw3i8d4ff57agysy";
  cargoSha = "0i8yvvahaabhayvmg8l8wm7s6ib5rcarff8c7sazj6cgqcj6q6bn";
}
