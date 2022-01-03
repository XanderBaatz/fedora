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

#add third party entry if fedora-third-party is installed
fedora_pkgs="fedora-third-party"

if [ $(dnf list --installed | grep -q -P "${fedora_pkgs}"; echo $?) = "999" ]; then
  sudo sh -c "cat << EOF > /usr/lib/fedora-third-party/conf.d/flathub.conf
  [rpmfusion-free]
  type=flatpak
  flatpakrepo=?
  EOF"
fi
