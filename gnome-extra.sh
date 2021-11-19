#!/bin/sh
# wget -qO- https://git.io/J12Ul | sh

#install base packages
sudo dnf install -y \
chrome-gnome-shell gnome-tweaks @development-tools \
gnome-terminal-nautilus xdg-user-dirs xdg-user-dirs-gtk ffmpegthumbnailer file-roller-nautilus \
gnome-calculator gnome-system-monitor gnome-disk-utility gedit google-noto-emoji-color-fonts \
gnome-shell-extension-appindicator gnome-shell-extension-gsconnect \
papirus-icon-theme

#tiling window manager extension with working shortcuts
sudo dnf install -y -setopt=install_weak_deps=False \
gnome-shell-extension-pop-shell xprop

#Open gsconnect ports in firewalld to enable connection
#sudo firewall-cmd --zone=public --permanent --add-port=1714-1764/tcp
#sudo firewall-cmd --zone=public --permanent --add-port=1714-1764/udp
#sudo systemctl restart firewalld.service

# Enable gdm display manager and enable graphical desktop

#Remove gnome-tour? (check workspace switching)

#Enable installed extensions on next boot

#Disable mouse accel for all users using gsettings

#Download and set wallpaper

#Make adwaita-dark the theme for all users (gsettings)

#Make papirus icon theme the default for all users
