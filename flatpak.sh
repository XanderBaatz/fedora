#!/bin/sh
# wget -qO- https://git.io/Jykln | sh
# curl -fsSL https://git.io/Jykln | sh

#check for root privileges
if [ $(id -u) != 0 ]; then
  exec sudo -- "$0" "$@"
fi

#install flatpak and add flathub repo
sudo dnf install -y flatpak

#add and enable third party entry if fedora-third-party is installed
fedora_pkgs="fedora-third-party"
fedoratp_dir="/usr/lib/fedora-third-party/conf.d"
flathub_url="https://flathub.org/repo/flathub.flatpakrepo"

if [ $(dnf list --installed | grep -q -P "${fedora_pkgs}"; echo $?) = "0" ]; then
  # download flathub repo file
  wget -qO- https://flathub.org/repo/flathub.flatpakrepo
  
  # add third party repo
  sudo sh -c "cat << EOF > ${fedoratp_dir}/flathub.conf
  [flathub]
  type=flatpak
  flatpakrepo=${flathub_url}
  EOF"
  
  # enable third party repos
  
else
  # add flathub repo through flatpak
  flatpak remote-add --if-not-exists flathub ${flathub_url}
fi
