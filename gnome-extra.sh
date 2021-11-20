#!/bin/sh
# wget -qO- https://git.io/J12Ul | sh

#install base packages
sudo dnf install -y \
gnome-extensions-app chrome-gnome-shell gnome-tweaks @development-tools \
gnome-terminal-nautilus xdg-user-dirs xdg-user-dirs-gtk ffmpegthumbnailer file-roller-nautilus \
gnome-calculator gnome-system-monitor gnome-disk-utility gedit google-noto-emoji-color-fonts \
gnome-shell-extension-appindicator gnome-shell-extension-gsconnect \
papirus-icon-theme dbus-x11

#tiling window manager extension with working shortcuts
sudo dnf install -y --setopt=install_weak_deps=False \
gnome-shell-extension-pop-shell xprop

#gsettings
gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'
gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark'
gsettings set org.gnome.desktop.peripherals.mouse accel-profile 'flat'
gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu:minimize,maximize,close'

#gsettings (GDM)
sudo sh -c "
xhost +SI:localuser:gdm
sudo -u gdm gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'
sudo -u gdm gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark'
sudo -u gdm gsettings set org.gnome.desktop.peripherals.mouse accel-profile 'flat'
xhost -SI:localuser:gdm
"
