#!/bin/sh
# wget -qO- https://git.io/JDtlC | sh
# curl -fsSL https://git.io/JDtlC | sh

#prompt to select what repos you want enabled
# Minimal: only base rpmfusion free and nonfree
# Recommended: fedora workstation repos + Minimal
# All: rpmfusion tainted and all of the above

#install repositories and third-party repository manager
sudo dnf install -y \
fedora-third-party \
https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

#add rpmfusion entry configs to fedora-third-party
sudo sh -c "cat << EOF > /usr/lib/fedora-third-party/conf.d/rpmfusion.conf
[rpmfusion-free]
type=dnf

[rpmfusion-nonfree]
type=dnf
EOF"

#enable repos
sudo fedora-third-party enable
