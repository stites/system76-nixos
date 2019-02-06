# System76 nixos configurations

Supported models

| Model                | Contributors      | Status |
| -------------------- | ----------------- | ------ |
| `oryp4`              | [stites][stites]  | Nonexistent, active delevopment |

I'm only going to claim to support the 2018 Oryx Pro build (oryp4) since it's the one I actively use. That said, this repo will try to add nixos support to all system76-development repositories, attempting to reach parity with [system76-dev's stable PPA](https://launchpad.net/~system76-dev/+archive/ubuntu/stable). This _does_ mean that this repo will be opinionated about which kernels you can support.

On oryp4 support: the only comprehensive discussion for a non-ubuntu build that I could find was [_Installing Archlinux on System76's 2018 Oryx Pro (oryp4)_](https://ebobby.org/2018/07/15/archlinux-on-oryp4/) ([permalink](https://perma.cc/JQ7V-2FGN)).

Supported graphics for cuda: nvidia-410. Might need to check out [system76/cuda](https://github.com/system76/cuda) for compute support.

Repositories tracked (and releases):
- [pop-os/system76-firmware](https://github.com/pop-os/system76-firmware). Latest release 1.0.2 (05/08/2019)
- [pop-os/system76-dkms](https://github.com/pop-os/system76-dkms). Latest release: 1.0.4 (02/06/2019)
- [pop-os/system76-driver](https://github.com/pop-os/system76-driver). Latest release: 19.04.2 (01/31/2019)
- [pop-os/system76-power](https://github.com/pop-os/system76-power). Latest release: master (02/06/2019)
- [pop-os/hidpi-daemon](https://github.com/pop-os/hidpi-daemon). Latest release: 18.04.4 (08/01/2018)
- [pop-os/gtk-theme](https://github.com/pop-os/gtk-theme) (low priority). Latest release: 4.0.0-b2 (08/09/2018)
- [pop-os/system76-wallpapers](https://github.com/pop-os/system76-wallpapers) (low priority). Latest release: master (02/06/2019)
- [pop-os/system76-io-dkms](https://github.com/pop-os/system76-io-dkms) (low priority, theilo only). Latest release: 1.0.0 (12/04/2018)

[stites]: https://github.com/stites

### Discovered kernel modules you should probably load (for all system76 models)

See full list [system76-driver:system76driver/daemon.py](https://github.com/pop-os/system76-driver/blob/34c87f2a1ceb62fe95c1a0509bf2baf2949180c0/system76driver/daemon.py) for correct kernel modules which should be loaded.

### How to use

clone this repo in your `/etc/nixos/` folder. Add this folder as an import in `/etc/nixos/configuration.nix` and **remember to allowUnfree software if you have a system76 laptop with GPU support**:

```
# in /etc/nixos/configuration.nix
{
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
   ]
}
```


