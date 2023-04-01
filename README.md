# Fedora Workstation setup

## Post-install
Update and upgrade:
```
sudo sh -c "dnf --refresh upgrade -y && flatpak upgrade -y"
```

### RPM Fusion
Install RPM Fusion repos and the Appstream data provided by the RPM Fusion software repositories:
```
sudo sh -c "dnf install -y \
"https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm" \
"https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm" \
&& dnf group update -y core"
```

### Media codecs
Install Media codecs:
```
sudo dnf group upgrade -y --with-optional Multimedia
```

### (Optional) Fsync kernel
Fsync kernel, for gaming etc.:
```
sudo sh -c "dnf copr enable -y sentry/kernel-fsync && \
grep -qxF "exclude=kernel*" /etc/yum.repos.d/fedora-updates.repo || sed -i "/\[updates\]/a exclude=kernel*" /etc/yum.repos.d/fedora-updates.repo && \
dnf update --refresh -y"
```

### (Optional) NVIDIA Driver
Install NVIDIA driver (for more recent NVIDIA GPUs):
```
sudo dnf install -y akmod-nvidia
```

## Settings, tweaks etc.
### Mouse / pointer / touchpad
Disable mouse acceleration:
```
gsettings set org.gnome.desktop.peripherals.mouse accel-profile flat
```

### DNF software package manager
DNF settings optimizations:
```
sudo sh -c "cat << EOF >> /etc/dnf/dnf.conf
max_parallel_downloads=10
fastestmirror=true
EOF"
```



## Personalization etc.
### Fonts
Install proprietary Microsoft fonts for compatibility reasons (e.g. Maple):
```
sudo sh -c "dnf copr enable -y adrienverge/some-nice-fonts && dnf install -y some-nice-fonts"
```

Alternative method (with more/other fonts):
https://www.fosslinux.com/42406/how-to-install-microsoft-truetype-fonts-on-fedora.htm

### Themes
GTK3 libadwaita port (makes GTK3 apps look like GTK4+):
```
sudo sh -c "dnf copr enable -y nickavem/adw-gtk3 && dnf install -y adw-gtk3"
```
