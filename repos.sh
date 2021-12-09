#!/bin/sh
# wget -qO- https://git.io/XXXXX | sh

#install repositories and third-party repository manager
sudo dnf install -y \
fedora-workstation-repositories \
https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

#add rpmfusion entry configs to fedora-third-party
