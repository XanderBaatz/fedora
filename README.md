# Fedora Workstation setup

## Post-install
Update and upgrade:
```
sudo sh -c "dnf --refresh upgrade -y && flatpak upgrade -y"
```

### RPM Fusion
Install RPM Fusion repos and the Appstream data provided by the RPM Fusion software repositories:
```
sudo sh -c "dnf install \
"https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm" \
"https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm" \
&& dnf group update core"
```

### Media codecs
```
sudo dnf group upgrade --with-optional Multimedia
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
Install Microsoft fonts for compatibility (e.g. Maple):
https://www.fosslinux.com/42406/how-to-install-microsoft-truetype-fonts-on-fedora.htm

Microsoft fonts copr repo:
https://copr.fedorainfracloud.org/coprs/adrienverge/some-nice-fonts/
