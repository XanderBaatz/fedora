# Universal Blue Specific Changes

## Kernel

### Kernel Command Line
First, make a drop-in directory to not overwrite the default `grub` file:
```
sudo mkdir -p /etc/default/grub.d
```

Make a configuration file to add changes:
```
sudo nano /etc/default/grub.d/00-custom.cfg
```

To see current kernel parameters:
```
cat /proc/cmdline
```

E.g. to disable the annoying color profile change happening on AMD GPUs during low-power mode, add:
```
GRUB_CMDLINE_LINUX_DEFAULT="amdgpu.abmlevel=0"
```

Regenerate GRUB config to apply changes:
```
sudo grub2-mkconfig -o /boot/efi/EFI/fedora/grub.cfg
sudo grub2-mkconfig -o /boot/grub2/grub.cfg
```