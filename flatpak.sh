#!/bin/sh
# wget -qO- https://git.io/XXXXX | sh
# curl -fsSL https://git.io/XXXXX | sh

#install flatpak and add flathub repo
sudo dnf install -y flatpak && \
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
