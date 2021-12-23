#!/bin/sh

# wget -q https://git.io/JDtlC -O rpmfusion.sh && chmod +x rpmfusion.sh && ./rpmfusion.sh


# check for root privileges
if [ $(id -u) -ne 0 ]; then
  exec sudo -- "$0" "$@"
fi

# message
_msg() {
    echo "=>" "$@"
}


### installer script

usage() {
  echo "usage: "$0" [-w | --workstation] [-t | --tainted]"
  exit 2
}

PARSED_ARGUMENTS=$(getopt -a -n "$0" -o wt --long workstation,tainted -- "$@")
VALID_ARGUMENTS=$?
if [ "$VALID_ARGUMENTS" != "0" ]; then
  usage
fi

eval set -- "$PARSED_ARGUMENTS"
while :
do
  case "$1" in
    -w | --workstation)  workstation=true     ; shift   ;;
    -t | --tainted)      tainted=true         ; shift   ;;
    #
    --) shift; break ;;
    #
    *) echo "Unexpected option: $1 - invalid argument."
       usage ;;
  esac
done


# install repositories and third-party repository manager

_normal() {
  _msg "Installing RPM Fusion repos ..."
  sudo dnf install -y -q \
  fedora-third-party \
  https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
  https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm \

  # add rpmfusion entry configs to fedora-third-party
  sudo sh -c "cat << EOF > /usr/lib/fedora-third-party/conf.d/rpmfusion.conf
[rpmfusion-free]
type=dnf

[rpmfusion-nonfree]
type=dnf
EOF"
}

_workstation() {
  _msg "Installing workstation repos ..."
  # Install rpmfusion tainted repos
  sudo dnf install -y -q \
  fedora-workstation-repositories
}

_tainted() {
  _msg "Installing RPM Fusion Tainted repos ..."
  # Install rpmfusion tainted repos
  sudo dnf install -y -q \
  rpmfusion-free-release-tainted \
  rpmfusion-nonfree-release-tainted

  # append tainted repos to fedora-third-party
  sudo sh -c "cat << EOF >> /usr/lib/fedora-third-party/conf.d/rpmfusion.conf

[rpmfusion-free-tainted]
type=dnf

[rpmfusion-nonfree-tainted]
type=dnf
EOF"
}

_enable_repos() {
  _msg "Enabling repos."
  sudo fedora-third-party enable
}

_normal

if [ "$workstation" = "true" ]; then
  _msg "Fedora third party Workstation repos will be installed."
  _workstation
fi

if [ "$tainted" = "true" ]; then
  _msg "RPM Fusion Tainted repos will be installed."
  _tainted
fi

_enable_repos
