#!/bin/sh
# wget -qO- https://git.io/XXXXX | sh

#install base packages
sudo dnf install -y gdm gnome-shell gnome-terminal nautilus

# Enable gdm display manager and enable graphical desktop
sudo systemctl enable gdm
sudo systemctl set-default graphical.target

