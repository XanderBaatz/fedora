#!/bin/sh
# wget -qO- https://git.io/XXXXX | sh

#install base packages
sudo dnf install -y gdm gnome-shell gnome-terminal nautilus

#

#systemctl enable gdm; # Enable login using graphical interface
#systemctl set-default graphical.target; # Boot to graphical interface as default
