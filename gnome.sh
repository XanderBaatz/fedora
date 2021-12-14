#!/bin/sh
# wget -qO- https://git.io/JXD3d | sh
# curl -fsSL https://git.io/JXD3d | sh

# Credits: https://github.com/PapirusDevelopmentTeam/papirus-icon-theme
#          https://www.certdepot.net/rhel7-get-started-package-groups/
#          https://www.shellscript.sh/tips/getopt/index.html

#check for root privileges
if [ $(id -u) != 0 ]; then
  echo ""
  echo "Root priviliges required to run commands."
  exec sudo -- "$0" "$@"
fi


### installer script

usage() {
  echo "Usage: "$0" [ -m | --minimal ]
  		     [ -n | --nothemes ]
  		     [ -s | --storeinclude ]
  		     [ -u | --uninstall ]"
  exit 2
}

PARSED_ARGUMENTS=$(getopt -a -n "$0" -o mns --long minimal,nothemes,store -- "$@")
VALID_ARGUMENTS=$?
if [ "$VALID_ARGUMENTS" != "0" ]; then
  usage
fi

eval set -- "$PARSED_ARGUMENTS"
while :
do
  case "$1" in
    -m | --minimal)       norminst=false     ; shift   ;;
    -n | --nothemes)      themes=false       ; shift   ;;
    -s | --storeinclude)  store=true         ; shift   ;;
    -u | --uninstall)     uninstall=true     ; shift   ;;
    # -- means the end of the arguments; drop this, and break out of the while loop
    --) shift; break ;;
    # If invalid options were passed, then getopt should have reported an error,
    # which we checked as VALID_ARGUMENTS when getopt was called...
    *) echo "Unexpected option: $1 - invalid argument."
       usage ;;
  esac
done


### package list compiler

pkgs="@critical-path-gnome"

if [ "$store" != "true" ]; then
  echo "Store will not be installed."
  dnf_opts="--setopt=group_package_types=mandatory"
else
  echo "Store will be installed."
fi

if [ "$norminst" != "false" ]; then
  echo "Normal installation."
  pkgs="$pkgs \
        @development-tools \
        nautilus \
        gnome-extensions-app \
        chrome-gnome-shell \
        gnome-tweaks \
        gnome-terminal-nautilus \
	xdg-user-dirs \
	xdg-user-dirs-gtk \
	file-roller-nautilus \
	gtkhash-nautilus \
	gnome-calculator \
	gnome-system-monitor \
	gnome-disk-utility \
	gedit \
	google-noto-emoji-color-fonts \
	gnome-shell-extension-appindicator \
	dbus-x11 \
	gvfs-goa \
	"
else
  echo "Minimal installation."
fi

if [ "$themes" != "false" ]; then
  echo "Themes will be installed."
  pkgs="$pkgs \
	papirus-icon-theme \
	"
else
  echo "Themes will not be installed."
fi


# functions

_msg() {
    echo "=>" "$@"
}

_uninstall() {
    _msg "Removing packages ..."
    echo sudo dnf autoremove -y ${pkgs} | sh
}

_install() {
    _msg "Installing packages ..." && while :;do for s in / - \\ \|; do printf "\r$s";sleep .1;done;done
    echo sudo dnf install -y -q --setopt=exclude=gnome-tour ${dnf_opts} ${pkgs} | sh
    # Enable gdm display manager and enable graphical desktop
    echo sudo systemctl enable gdm | sh
    echo sudo systemctl set-default graphical.target | sh
}


### execution

if [ "$uninstall" != "true" ]; then
  _install
else
  _uninstall
fi
