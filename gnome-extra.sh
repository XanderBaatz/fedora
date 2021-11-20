#!/bin/sh
# wget -qO- https://git.io/J12Ul | sh

#install base packages
sudo dnf install -y \
chrome-gnome-shell gnome-tweaks @development-tools \
gnome-terminal-nautilus xdg-user-dirs xdg-user-dirs-gtk ffmpegthumbnailer file-roller-nautilus \
gnome-calculator gnome-system-monitor gnome-disk-utility gedit google-noto-emoji-color-fonts \
gnome-shell-extension-appindicator gnome-shell-extension-gsconnect \
papirus-icon-theme dbus-x11

#tiling window manager extension with working shortcuts
sudo dnf install -y --setopt=install_weak_deps=False \
gnome-shell-extension-pop-shell xprop

#Open gsconnect ports in firewalld to enable connection
#sudo firewall-cmd --zone=public --permanent --add-port=1714-1764/tcp
#sudo firewall-cmd --zone=public --permanent --add-port=1714-1764/udp
#sudo systemctl restart firewalld.service

#gsettings
gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'
gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark'
gsettings set org.gnome.desktop.peripherals.mouse accel-profile 'flat'
gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu:minimize,maximize,close'

#gsettings (GDM)
sudo sh -c "
xhost +SI:localuser:gdm
sudo su gdm -s /bin/bash
gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'
gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark'
gsettings set org.gnome.desktop.peripherals.mouse accel-profile 'flat'
exit && xhost -SI:localuser:gdm
"

echo "hello, testing!"

#Remove gnome-tour? (check workspace switching)

#Enable installed extensions on next boot

#Disable mouse accel for all users using gsettings

#Download and set wallpaper

#Make adwaita-dark the theme for all users (gsettings)

#Make papirus icon theme the default for all users
