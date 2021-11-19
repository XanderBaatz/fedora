#!/bin/sh
# wget -qO- https://git.io/JXD3d | sh

# https://www.certdepot.net/rhel7-get-started-package-groups/

#install base packages
sudo dnf install -y --setopt=group_package_types=mandatory @critical-path-gnome
#sudo dnf install -y gdm gnome-shell gnome-terminal nautilus
#sudo dnf install -y @critical-path-gnome

# Enable gdm display manager and enable graphical desktop
sudo systemctl enable gdm
sudo systemctl set-default graphical.target

#Remove gnome-tour? (check workspace switching)

#Enable installed extensions on next boot

#Disable mouse accel for all users using gsettings

#Download and set wallpaper

#Make adwaita-dark the theme for all users (gsettings)

#Make papirus icon theme the default for all users
