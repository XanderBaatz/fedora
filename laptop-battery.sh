#!/bin/sh
# wget -qO- https://git.io/XXXXX | sh

#exit if network-manager isn't installed
if [ $(dnf list --installed | grep -q -P "power-profiles-daemon"; echo $?) = "0" ]; then
  sudo systemctl mask power-profiles-daemon.service
fi

