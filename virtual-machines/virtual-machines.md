# Fedora Virtual Machines
Links:

- https://docs.fedoraproject.org/en-US/quick-docs/getting-started-with-virtualization/#enabling-hardware-virtualization-support
- https://christitus.com/vm-setup-in-linux/
- https://dev.to/christianbueno1/install-windows-11-virtual-machine-on-kvm-libvirt-qemu-virt-manager-in-linux-fedora-3637-rpm-based-distribution-1nkd

## Windows
HyperV XML fix:

In `Overview -> XML` under `<hyperv>`:

```
    <hyperv>
      <relaxed state="on"/>
      <vapic state="on"/>
      <spinlocks state="on" retries="8191"/>
      <vpindex state='on'/>
      <runtime state='on'/>
      <stimer state='on'/>
      <synic state='on'/>
      <reset state='on'/>
      <frequencies state='on'/>
    </hyperv>
```
