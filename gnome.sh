#!/bin/sh
# wget -qO- https://git.io/JXD3d | sh
# curl -fsSL https://git.io/JXD3d | sh

# Credits: https://github.com/PapirusDevelopmentTeam/papirus-icon-theme
#          https://www.certdepot.net/rhel7-get-started-package-groups/

set -e

#check for root privileges
if [ $(id -u) != 0 ]; then
  echo ""
  echo "Root priviliges required to run commands."
  exec sudo -- "$0" "$@"
fi

# env args
: "${apps:=true}"
: "${themes:=true}"
: "${uninstall:=false}"

_msg() {
    echo "=>" "$@"
}

_uninstall() {
    _msg "Removing packages ..."
    sudo dnf autoremove -y
}

_install() {
    _msg "Installing packages ..."
    sudo dnf install -y
}

if [ "$themes" != "true" ]; then
    _install "$ICON_THEMES"
else
    _uninstall "$ICON_THEMES"
fi

if [ "$uninstall" = "false" ]; then
    _install "$ICON_THEMES"
else
    _uninstall "$ICON_THEMES"
fi

#install base packages
sudo dnf install -y --setopt=group_package_types=mandatory --setopt=exclude=gnome-tour \
@critical-path-gnome nautilus

# Enable gdm display manager and enable graphical desktop
sudo systemctl enable gdm
sudo systemctl set-default graphical.target
