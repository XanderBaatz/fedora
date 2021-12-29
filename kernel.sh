#!/bin/sh

# wget -qO- https://git.io/XXXXX | sh
# wget -q https://git.io/XXXXX -O rpmfusion.sh && chmod +x rpmfusion.sh && ./rpmfusion.sh


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
  echo "usage: "$0" [-t | --tainted] [-u | --uninstall]"
  exit 2
}

PARSED_ARGUMENTS=$(getopt -a -n "$0" -o eu --long exclude,uninstall -- "$@")
VALID_ARGUMENTS=$?
if [ "$VALID_ARGUMENTS" != "0" ]; then
  usage
fi

eval set -- "$PARSED_ARGUMENTS"
while :
do
  case "$1" in
    -w | --workstation)  exclude=true     ; shift   ;;
    -t | --tainted)      uninstall=true   ; shift   ;;
    #
    --) shift; break ;;
    #
    *) echo "Unexpected option: $1 - invalid argument."
       usage ;;
  esac
done


# install repositories and third-party repository manager

_install() {
  _msg "Installing Fedora fsync patched kernel ..."
  sudo dnf copr enable sentry/kernel-fsync -y -q && \
  sudo dnf update --refresh -q -y

  # add rpmfusion entry configs to fedora-third-party
  sudo sh -c "cat << EOF > /usr/lib/fedora-third-party/conf.d/kernel-fsync.conf
[copr:copr.fedorainfracloud.org:sentry:kernel-fsync]
type=dnf
EOF"
}

_enable_repos() {
  _msg "Enabling repos."
  sudo fedora-third-party enable
}

_install

if [ "$uninstall" = "true" ]; then
  _msg "Fedora third party Workstation repos will be installed."
  _workstation
fi

_enable_repos
