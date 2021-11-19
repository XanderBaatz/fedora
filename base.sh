#!/bin/sh
# wget -qO- https://git.io/J1Keq | sh

#Credits:
# https://forums.fedoraforum.org/showthread.php?324485-steps-After-install
# https://bluehatrecord.wordpress.com/2015/10/06/the-hidden-dnf-groups-of-the-fedora-repositories/

# Check for updates
sudo sh -c 'dnf --refresh check-upgrade -y && dnf upgrade -y'

#Required repositories
sudo dnf install -y \
https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

#audio, bluetooth, wi-fi
sudo dnf install -y @hardware-support @networkmanager-submodules @multimedia