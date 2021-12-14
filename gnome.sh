#!/bin/sh
# wget -qO- https://git.io/JXD3d | sh

set -e

# https://www.certdepot.net/rhel7-get-started-package-groups/

#install base packages
sudo dnf install -y --setopt=group_package_types=mandatory --setopt=exclude=gnome-tour \
@critical-path-gnome nautilus

# Enable gdm display manager and enable graphical desktop
sudo systemctl enable gdm
sudo systemctl set-default graphical.target
