#!/bin/sh
# wget -qO- https://git.io/J1Keq | sh

#Credits:
# https://forums.fedoraforum.org/showthread.php?324485-steps-After-install
# https://bluehatrecord.wordpress.com/2015/10/06/the-hidden-dnf-groups-of-the-fedora-repositories/

#check for root privileges
if [ "$(whoami)" != "root" ]; then
  echo ""
  echo "Root priviliges required to run commands."
  exec sudo -- "$0" "$@"
fi

# Check for updates
dnf --refresh check-upgrade -y && dnf upgrade -y

#audio, bluetooth, wi-fi
dnf install -y @hardware-support @networkmanager-submodules @multimedia
