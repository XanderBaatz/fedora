#!/bin/sh
# wget -qO- https://git.io/JXD3d | sh

#install base packages
sudo dnf install -y gdm gnome-shell gnome-terminal nautilus \
chrome-gnome-shell gnome-tweaks @development-tools \
gnome-terminal-nautilus xdg-user-dirs xdg-user-dirs-gtk ffmpegthumbnailer file-roller-nautilus \
gnome-calculator gnome-system-monitor gnome-disk-utility gedit google-noto-emoji-color-fonts gnome-shell-extension-appindicator

# Enable gdm display manager and enable graphical desktop
sudo systemctl enable gdm
sudo systemctl set-default graphical.target
