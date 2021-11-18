#!/bin/sh
# wget -qO- https://git.io/XXXXX | sh

#install base packages
sudo dnf install -y gnome-shell-extension-gsconnect

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
