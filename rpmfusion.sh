#!/bin/sh
# wget -qO- https://git.io/JDtlC | sh

#install repositories and third-party repository manager
sudo dnf install -y \
fedora-workstation-repositories \
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
