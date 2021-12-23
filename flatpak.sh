#!/bin/sh
# wget -qO- https://git.io/Jykln | sh
# curl -fsSL https://git.io/Jykln | sh

#check for root privileges
if [ $(id -u) != 0 ]; then
  exec sudo -- "$0" "$@"
fi

#install flatpak and add flathub repo
sudo dnf install -y flatpak && \
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
