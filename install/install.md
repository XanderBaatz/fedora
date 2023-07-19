# Install guide - tips and tricks

## Disk management

### Secure erase - NVME
Easy way to secure erase using `nvme-cli`:

https://askubuntu.com/a/1310876

To list NVMe drives:
```
nvme list
```

Secure erase (note this will wipe your drive):
```
nvme format -s1 <device>
```

e.g.:
```
nvme format -s1 /dev/nvme0n1
```

To target all namespaces:
```
nvme format -s1 -n 0xffffffff /dev/nvme0n1
```

### UEFI boot list
Remove old/unused entries from the UEFI boot list using `efibootmgr`:

https://tecporto.pt/wiki/index.php/Removing_an_entry_from_the_UEFI_boot_list_(Linux)

To list EFI boot entries:
```
efibootmgr
```

E.g. to remove boot entry one (0001):
```
efibootmgr -b 1 -B
```
