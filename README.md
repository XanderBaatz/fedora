# Fedora Workstation setup

## Post-install
Update, upgrade and reboot:
```
sudo sh -c "dnf --refresh upgrade -y && flatpak upgrade -y && reboot"
```

### RPM Fusion
Install RPM Fusion repos and the Appstream data provided by the RPM Fusion software repositories:
```
sudo sh -c "dnf install -y \
"https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm" \
"https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm" \
&& dnf group update -y core"
```

### Update firmware
Update firmware using Firmware Update Manager:
```
sudo sh -c "fwupdmgr get-devices && fwupdmgr refresh --force && fwupdmgr get-updates && fwupdmgr update"
```

### Media codecs
Note: do the following after installing RPM Fusion repositories.

Install Media codecs:
```
sudo dnf group upgrade -y --with-optional Multimedia --allowerasing
```

Additionally, switch to ffmpeg with patented codecs:
```
sudo dnf swap ffmpeg ffmpeg-free --allowerasing
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

---

## Settings, tweaks etc.
### Mouse / pointer / touchpad
Disable mouse acceleration:
```
gsettings set org.gnome.desktop.peripherals.mouse accel-profile 'flat'
```

### Nautilus (file manager)
Sort folders before files:
```
gsettings set org.gtk.Settings.FileChooser sort-directories-first 'true'
```

### DNF software package manager
DNF settings optimizations:
```
grep -qxF "fastestmirror=" /etc/dnf/dnf.conf || sudo sed -i "/\[main\]/a fastestmirror=True" $_
grep -qxF "max_parallel_downloads=" /etc/dnf/dnf.conf || sudo sed -i "/\[main\]/a max_parallel_downloads=10" $_
```

### Lockscreen settings
Install Login Manager Settings:
```
flatpak install flathub io.github.realmazharhussain.GdmSettings
```
1. Open Login Manager Settings
2. Go to ``Display``
3. Click ``Apply`` under ``Apply current display settings``
4. Apply the changes by clicking ``Apply`` in the top part of the window


## Personalization etc.
### Fonts
Install proprietary Microsoft fonts for compatibility reasons (e.g. Maple):
```
sudo sh -c "dnf copr enable -y adrienverge/some-nice-fonts && dnf install -y some-nice-fonts"
```

Alternative method (with more/other fonts):
https://www.fosslinux.com/42406/how-to-install-microsoft-truetype-fonts-on-fedora.htm

Substitutions for popular proprietary fonts from Microsoft, Apple etc.:
```
sudo sh -c "dnf copr enable dawid/better_fonts -y && dnf install fontconfig-font-replacements -y
```

Additionally, one can also install:
```
sudo dnf install -y liberation-fonts
```

### Themes
GTK3 libadwaita port (makes GTK3 apps look like GTK4+):
```
sudo sh -c "dnf copr enable -y nickavem/adw-gtk3 && dnf install -y adw-gtk3"
```
Change the theme and turn on dark mode:
```
gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3-dark' \
&& gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
```

### Firefox GNOME theme
One command curled script to auto-download and install the latest version of the theme (from https://github.com/rafaelmardojai/firefox-gnome-theme):
```
curl -s -o- https://raw.githubusercontent.com/rafaelmardojai/firefox-gnome-theme/master/scripts/install-by-curl.sh | bash
```

### Extensions
Install Extension Manager:
```
flatpak install flathub com.mattjakeman.ExtensionManager
```

Extensions:

- Alphabetical App Grid
- AppIndicator and KStatusNotifierItem Support
- Just Perfection

## Applications and repos
Audio, pluign etc. repo:
```
dnf copr enable -y ycollet/audinux
```

## Kernel compilation
Refer to:
https://odysee.com/@mumblingdrunkard:7/20210405-fedora-patch-compile-and-install-kernel:0

Kernel patches, made using the difference between two files (a and b):
```
git diff a b > patchfile.patch
```

