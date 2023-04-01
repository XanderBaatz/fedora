# Fedora Workstation setup

## Post-install
Update and upgrade:
```
sudo sh -c "dnf --refresh upgrade -y && flatpak upgrade -y"
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
