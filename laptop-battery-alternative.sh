#!/bin/sh
# wget -qO- https://git.io/XXXXX | sh

#disable power-profiles-daemon if installed (tlp and ppd can't run simultaneously)
if [ $(dnf list --installed | grep -q -P "power-profiles-daemon"; echo $?) = "0" ]; then
  sudo systemctl mask power-profiles-daemon.service
fi

#install tlp and tlp-rdw
sudo dnf install -y tlp tlp-rdw

#start tlp without reboot
sudo tlp start

#disable rfkill to avoid radio switching conflict
sudo systemctl mask systemd-rfkill.socket
sudo systemctl mask systemd-rfkill.service
