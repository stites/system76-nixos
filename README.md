# System76 nixos configurations

Supported models

| Model                | Contributors      | Status |
| -------------------- | ----------------- | ------ |
| `oryp4`              | [stites][stites]  |  |
| `darp6`              | [khumba][khumba]  |        |

[stites]: https://github.com/stites
[khumba]: https://github.com/khumba


This repo was/is an attempt to add nixos support to all system76-development repositories, attempting to reach parity with [system76-dev's stable PPA](https://launchpad.net/~system76-dev/+archive/ubuntu/stable). This _does_ mean that this repo may be opinionated about which kernels you can support. *I ([stites][stites]) am no longer maintaining this repository and am planning on pushing it up to https://github.com/NixOS/nixos-hardware -- feel free to initiate this effort* 

On oryp4 support: the only comprehensive discussion for a non-ubuntu build that I could find was [_Installing Archlinux on System76's 2018 Oryx Pro (oryp4)_](https://ebobby.org/2018/07/15/archlinux-on-oryp4/) ([permalink](https://perma.cc/JQ7V-2FGN)).

Repositories tracked (as well as last known release and status):

| Package                                                              | Last known release | Last release date | Last checked | Notes  |
| -------------------------------------------------------------------- | ------------------ | ----------------- | ------------ | ------ |
| [system76-acpi-dkms](https://github.com/pop-os/system76-acpi-dkms)   | 1.0.1              | 10/15/2019        | 03/22/2020   | incomplete |
| [system76-dkms](https://github.com/pop-os/system76-dkms)             | 1.0.6              | 06/06/2019        | 03/22/2020   | untested |
| [system76-driver](https://github.com/pop-os/system76-driver)         | 19.04.2            | 01/31/2019        | 02/06/2018   | incomplete |
| [system76-io-dkms](https://github.com/pop-os/system76-io-dkms)       | 1.0.1              | 06/04/2019        | 03/22/2020   | incomplete |
| [system76-firmware](https://github.com/pop-os/system76-firmware)     | 1.0.2              | 05/08/2019        | 02/06/2018   | untested |
| [system76-power](https://github.com/pop-os/system76-power)           | none               | 02/06/2019        | 02/06/2018   | incomplete |
| [hidpi-daemon](https://github.com/pop-os/hidpi-daemon)               | 18.04.4            | 08/01/2018        | 02/06/2018   | incomplete |
| [gtk-theme](https://github.com/pop-os/gtk-theme)                     | 4.0.0-b2           | 08/09/2018        | 02/06/2018   | incomplete, low priority |
| [system76-wallpapers](https://github.com/pop-os/system76-wallpapers) | none               | 02/06/2019        | 02/06/2018   | incomplete, low priority |
| [system76-io-dkms](https://github.com/pop-os/system76-io-dkms)       | 1.0.0              | 12/04/2018        | 02/06/2018   | incomplete, low priority, theilo only |


### Discovered kernel modules you should probably load (for all system76 models)

See full list [system76-driver:system76driver/daemon.py](https://github.com/pop-os/system76-driver/blob/34c87f2a1ceb62fe95c1a0509bf2baf2949180c0/system76driver/daemon.py) for correct kernel modules which should be loaded.

### How to use

clone this repo in your `/etc/nixos/` folder. Add this folder as an import in `/etc/nixos/configuration.nix` and **remember to allowUnfree software if you have a system76 laptop with GPU support**:

```
# in /etc/nixos/configuration.nix
{
  hardware.system76.enable = true;

  # Supported options: generic (default), darp6
  # This controls which kernel modules are installed.
  #hardware.system76.model = "generic";

  # for nvidia-supported laptops
  nixpkgs.config.allowUnfree = true;

  imports =
    [ ...

      # if you want to import defaults
      ./system76-nixos

      # I think this would also work?
      builtins.fetchGit { url="https://github.com/stites/system76-nixos"; ref="master"; }}

      # if you want something more granular
     "${builtins.fetchGit { url="https://github.com/stites/system76-nixos"; ref="master"; }}/if-you-want-a-specific-file.nix"
   ];
}
```


