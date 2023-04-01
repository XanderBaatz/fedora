# Fedora Workstation setup

## Post-install
Update and upgrade:
```
sudo sh -c "dnf --refresh upgrade -y && flatpak upgrade -y"
```

## Settings, tweaks etc.
Disable mouse acceleration:
```
gsettings set org.gnome.desktop.peripherals.mouse accel-profile flat
```


## Personalization etc.
### Fonts
Install Microsoft fonts for compatibility (e.g. Maple):
https://www.fosslinux.com/42406/how-to-install-microsoft-truetype-fonts-on-fedora.htm

Microsoft fonts copr repo:
https://copr.fedorainfracloud.org/coprs/adrienverge/some-nice-fonts/
