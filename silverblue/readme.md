# Fedora Silverblue setup

## Post-install

### Update
Update, upgrade and reboot:
```
rpm-ostree upgrade -y && systemctl reboot
```

### Rebase - Universal Blue
Community Fedora Silverblue images - optionally with NVIDIA drivers built-in.

#### Ublue Main
Rebase to Universal Blue Main, if one's not running an NVIDIA GPU: https://github.com/ublue-os/main

Rebase command:
```
rpm-ostree rebase ostree-unverified-registry:ghcr.io/ublue-os/silverblue-main:latest
```

#### Ublue NVIDIA
Rebase to Universal Blue NVIDIA, if one's running an NVIDIA GPU: https://github.com/ublue-os/nvidia

Rebase command:
```
rpm-ostree rebase ostree-unverified-registry:ghcr.io/ublue-os/silverblue-nvidia:stable
```

Or:
```
rpm-ostree rebase ostree-unverified-registry:ghcr.io/ublue-os/silverblue-nvidia:latest
```

### Package Layering
Layer "essential" packages:
```
rpm-ostree install \
gnome-shell-extension-appindicator \
gnome-shell-extension-dash-to-dock \
gnome-shell-extension-gsconnect \
code \
gnome-boxes \
virt-install \
virt-manager \
virt-viewer \
```

#### VSCode
Add [VSCode](https://code.visualstudio.com/docs/setup/linux#_rhel-fedora-and-centos-based-distributions) repo:

```bash
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
```

Install VSCode:

```bash
rpm-ostree install code
```
