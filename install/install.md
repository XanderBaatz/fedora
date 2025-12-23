# Install Guide

## 🔌 Bootable USB

Make a multi-bootable USB using [Ventoy](https://www.ventoy.net/en/index.html).

1. [Download Ventoy](https://www.ventoy.net/en/download.html).
2. Extract it (e.g. `ventoy-1.1.05-linux.tar.gz`).
3. Plug in a USB.
4. Run `VentoyGUI.x86_64`.
5. Install Ventoy onto the USB. Use GPT parition if it's a big drive.
6. When it's installed, open the `Ventoy` folder created on the USB, and add any bootable ISOs.
7. Reboot into UEFI/BIOS.
    - Linux: ```systemctl reboot --firmware-setup```
    - Windows: ```shutdown /r /fw /t 0```

### Common ISOs
- [Fedora Workstation Live nightly builds](https://openqa.fedoraproject.org/nightlies.html/)
- [Ubuntu daily live builds](https://cdimage.ubuntu.com/daily-live/)
- [Bluefin DX build](https://download.projectbluefin.io/bluefin-dx-stable.iso)


## 💽 Disk Management

### 🔐 Secure erase - NVMe
Easy way to securely erase NVMe drives using [`nvme-cli`](https://askubuntu.com/a/1310876).

#### List NVMe Drives
```
nvme list
```

Check which erase operations are supported:
```
nvme id-ctrl --human-readable /dev/nvme0n1 | grep -i sanitize
```

#### ⚠️ Method 1: Format
Note that this will WIPE your drive (e.g. device can be `/dev/nvme0n1`):
```
nvme format -s1 <device>
```

To target all namespaces:
```
nvme format -s1 -n 0xffffffff <device>
```

Or use cryptographic erase:
```
nvme format /dev/nvme0n1 --ses=2
```

#### ⚠️ Method 2: Sanitize (better)
Better yet, if supported, use `sanitize` with crypto erase (deletes encryption key, very fast):
```
nvme sanitize <device> --sanact=start-block-erase --ause
```

Alternatively, use block-level erase (may negatively affect the longevity of the drive, but it's very thorough):
```
nvme sanitize /dev/nvme0n1 --sanact=start-block-erase --ause
```


## ⚙️ Configure UEFI Boot List
Remove old/unused entries from the UEFI boot menu using [`efibootmgr`](https://tecporto.pt/wiki/index.php/Removing_an_entry_from_the_UEFI_boot_list_(Linux)).

#### List EFI Boot Entries
To list EFI boot entries:
```
efibootmgr
```

#### Remove Boot Entry
To remove boot entry one (0001), run:
```
efibootmgr -b 1 -B
```