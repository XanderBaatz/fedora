# Fedora Workstation Setup

## Post-install
Update, upgrade and reboot:

```bash
sudo sh -c "dnf --refresh upgrade -y && flatpak upgrade -y && reboot"
```

## Enable Third Party Repositories

### RPM Fusion
Install RPM Fusion repos and the Appstream data provided by the RPM Fusion software repositories:

```bash
sudo sh -c "dnf install -y \
"https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm" \
"https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm" \
&& dnf group update -y core"
```

### Flathub
Add Flathub Flatpak repositories:

```bash
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
```

## Multimedia (Media codecs)
**Note:** Do the following after installing RPM Fusion repositories.

Install Media codecs:

```bash
sudo dnf group upgrade -y --with-optional Multimedia --allowerasing
```

Additionally, switch to `ffmpeg` with patented codecs:

```bash
sudo dnf swap ffmpeg ffmpeg-free --allowerasing
```

## Firmware and Drivers
Update firmware using Firmware Update Manager (`fwupdmgr`):

```bash
sudo sh -c "fwupdmgr get-devices && fwupdmgr refresh --force && fwupdmgr get-updates && fwupdmgr update"
```

### NVIDIA Drivers
Install NVIDIA driver (for more recent NVIDIA GPUs):

```bash
sudo dnf install -y akmod-nvidia
```

### (Optional) Fsync kernel
Fsync kernel, for gaming etc.:

```bash
sudo sh -c "dnf copr enable -y sentry/kernel-fsync && \
grep -qxF "exclude=kernel*" /etc/yum.repos.d/fedora-updates.repo || sed -i "/\[updates\]/a exclude=kernel*" /etc/yum.repos.d/fedora-updates.repo && \
dnf update --refresh -y"
```


## Aliases

### System Update Alias
```bash
#!/bin/bash

# Add sourcing of .bash_aliases to .bashrc
BASHRC="$HOME/.bashrc"
BASH_ALIASES="$HOME/.bash_aliases"

# Check if the sourcing line already exists in .bashrc
if ! grep -q "\. ~/.bash_aliases" "$BASHRC"; then
    echo -e "\n# Source custom aliases from ~/.bash_aliases\nif [ -f ~/.bash_aliases ]; then\n    . ~/.bash_aliases\nfi" >> "$BASHRC"
    echo "Added .bash_aliases sourcing to .bashrc"
else
    echo "Sourcing of .bash_aliases already exists in .bashrc"
fi

# Create or append to .bash_aliases with the sysup alias
ALIAS_LINE="alias sysup='sudo bash -c \"dnf --refresh upgrade -y && flatpak upgrade -y\"'"
if [ ! -f "$BASH_ALIASES" ]; then
    echo "# Update system" > "$BASH_ALIASES"
    echo "$ALIAS_LINE" >> "$BASH_ALIASES"
    echo "Created .bash_aliases with sysup alias"
elif ! grep -q "alias sysup=" "$BASH_ALIASES"; then
    echo "$ALIAS_LINE" >> "$BASH_ALIASES"
    echo "Appended sysup alias to .bash_aliases"
else
    echo "sysup alias already exists in .bash_aliases"
fi

# Source .bash_aliases to apply changes
source "$BASH_ALIASES"
echo "Applied changes by sourcing .bash_aliases"
```


## System Configurations, Tweaks and Settings

### Mouse / Pointer / Touchpad
Disable mouse acceleration:
```bash
gsettings set org.gnome.desktop.peripherals.mouse accel-profile 'flat'
```

### Nautilus (file manager)
Sort folders before files:
```
gsettings set org.gtk.Settings.FileChooser sort-directories-first 'true'
```

### DNF software package manager
DNF settings optimizations:
```bash
grep -qxF "fastestmirror=" /etc/dnf/dnf.conf || sudo sed -i "/\[main\]/a fastestmirror=True" $_
grep -qxF "max_parallel_downloads=" /etc/dnf/dnf.conf || sudo sed -i "/\[main\]/a max_parallel_downloads=10" $_
```

### Login Manager
Install Login Manager Settings:
```bash
flatpak install flathub io.github.realmazharhussain.GdmSettings
```

1. Open Login Manager Settings
2. Go to ``Display``
3. Click ``Apply`` under ``Apply current display settings``
4. Apply the changes by clicking ``Apply`` in the top part of the window


## Personalization

### Fonts

#### Default Font
Install the Inter font:
```bash
sudo dnf install inter-fonts
```

Set Inter as the default font:
```bash
gsettings set org.gnome.desktop.interface font-name 'Inter 10'
gsettings set org.gnome.desktop.interface document-font-name 'Inter 10'
gsettings set org.gnome.desktop.wm.preferences titlebar-font 'Inter Bold 10'
```


#### Fonts for compatibility
Install proprietary Microsoft fonts for compatibility reasons (e.g. Maple):
```bash
sudo sh -c "dnf copr enable -y adrienverge/some-nice-fonts && dnf install -y some-nice-fonts"
```

Alternative method (with more/other fonts):
https://www.fosslinux.com/42406/how-to-install-microsoft-truetype-fonts-on-fedora.htm

Substitutions for popular proprietary fonts from Microsoft, Apple etc.:
```bash
sudo sh -c "dnf copr enable dawid/better_fonts -y && dnf install fontconfig-font-replacements -y
```

Additionally, one can also install:
```bash
sudo dnf install -y liberation-fonts
```

### Themes
GTK3 libadwaita port (makes GTK3 apps look like GTK4+):
```bash
sudo dnf install adw-gtk3-theme
```

Change the theme and turn on dark mode:
```bash
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

System extensions:

```
sudo dnf install -y gnome-shell-extension-gsconnect \
gnome-shell-extension-appindicator
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

