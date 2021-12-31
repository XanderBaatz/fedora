#!/bin/sh

# wget -q https://git.io/JXD3d -O gnome.sh && chmod +x gnome.sh && ./gnome.sh

# Credits: https://github.com/PapirusDevelopmentTeam/papirus-icon-theme
#          https://www.certdepot.net/rhel7-get-started-package-groups/
#          https://www.shellscript.sh/tips/getopt/index.html

#check for root privileges
if [ $(id -u) -ne 0 ]; then
  echo ""
  echo "Root priviliges required to run commands."
  exec sudo -- "$0" "$@"
fi

_msg() {
    echo "=>" "$@"
}


### installer script

usage() {
  echo "usage: "$0" [-m | --minimal] [-n | --nothemes] [-s | --storeinclude] [-u | --uninstall]"
  exit 2
}

PARSED_ARGUMENTS=$(getopt -a -n "$0" -o mnsu --long minimal,nothemes,store,uninstall -- "$@")
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
    #
    --) shift; break ;;
    #
    *) echo "Unexpected option: $1 - invalid argument."
       usage ;;
  esac
done


### package list compiler

pkgs="@critical-path-gnome"

if [ "$store" != "true" ]; then
  _msg "Store will not be installed."
  dnf_opts="--setopt="group_package_types=mandatory""
else
  _msg "Store will be installed."
fi

if [ "$norminst" != "false" ]; then
  _msg "Normal installation."
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
        gvfs-mtp \
        "
else
  _msg "Minimal installation."
fi

if [ "$themes" != "false" ]; then
  _msg "Themes will be installed."
  pkgs="$pkgs \
	papirus-icon-theme \
	"
else
  _msg "Themes will not be installed."
fi


# functions

_load() {
	    sp="/-\|"
	sc=0
	spin() {
	   printf "\b${sp:sc++:1}"
	   ((sc==${#sp})) && sc=0
	}
	endspin() {
	   printf "\r%s\n" "$@"
	}

	until work_done; do
	   spin
	   $1
	done
	endspin
}

_uninstall() {
    _msg "Removing packages ..."
    echo sudo dnf autoremove -y ${pkgs} | sh
}

_install() {
    _msg "Installing packages ..."
    echo sudo dnf install -y --setopt="exclude=gnome-tour" ${dnf_opts} ${pkgs} | sh
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
