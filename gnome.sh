#!/bin/sh
# wget -qO- https://git.io/JXD3d | sh
# curl -fsSL https://git.io/JXD3d | sh

# Credits: https://github.com/PapirusDevelopmentTeam/papirus-icon-theme
#          https://www.certdepot.net/rhel7-get-started-package-groups/

set -e

# env args
: "${minimal:=false}"

_msg() {
    echo "=>" "$@"
}



#install base packages
sudo dnf install -y --setopt=group_package_types=mandatory --setopt=exclude=gnome-tour \
@critical-path-gnome nautilus

# Enable gdm display manager and enable graphical desktop
sudo systemctl enable gdm
sudo systemctl set-default graphical.target
