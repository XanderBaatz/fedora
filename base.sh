#!/bin/sh
# wget -qO- https://git.io/J1Keq | sh

#Credits:
# https://forums.fedoraforum.org/showthread.php?324485-steps-After-install
# https://bluehatrecord.wordpress.com/2015/10/06/the-hidden-dnf-groups-of-the-fedora-repositories/

#check for root privileges
#if [ "$(whoami)" != "root" ]; then
#  echo "Root priviliges required to run commands. Would you like to run as root and continue the script? [y/N]"
#fi

# Check for updates
sudo sh -c 'dnf --refresh check-upgrade -y && dnf upgrade -y'

#Test
# sudo dnf --setopt=group_package_types=mandatory,default,conditional groupinstall core

#Required repositories
sudo dnf install -y \
https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

#audio, bluetooth, wi-fi
sudo dnf install -y @hardware-support @networkmanager-submodules @multimedia
