#!/bin/sh
# wget -qO- https://git.io/J1gdu | sh

# Credits: https://gist.github.com/sebastiaanfranken/61474c1929ab256e4247a7a4a73262ca
#          https://www.if-not-true-then-false.com/2015/fedora-nvidia-guide/#nvidia-install
#          https://negativo17.org/nvidia-driver


# check for root privileges
if [ $(id -u) -ne 0 ]; then
  exec sudo -- "$0" "$@"
fi

# message function
_msg() {
    echo "=>" "$@"
}


### installer script

usage() {
  echo "usage: "$0" [-e | --exclude-nouveau] [-n | --negativo] [-u | --uninstall]"
  exit 2
}

PARSED_ARGUMENTS=$(getopt -a -n "$0" -o enu --long exclude-nouveau,negativo,uninstall -- "$@")
VALID_ARGUMENTS=$?
if [ "$VALID_ARGUMENTS" != "0" ]; then
  usage
fi

eval set -- "$PARSED_ARGUMENTS"
while :
do
  case "$1" in
    -e | --exclude-nouveau)       exclude=true     ; shift   ;;
    -n | --negativo)              negativo=false   ; shift   ;;
    -u | --uninstall)             uninstall=true   ; shift   ;;
    #
    --) shift; break ;;
    #
    *) echo "Unexpected option: $1 - invalid argument."
       usage ;;
  esac
done

#if rpmfusion or rpmfusion-nvidia not detected, add rpmfusion-nvidia repo

##########

#add Fedora Third Party repositories for Nvidia driver
#sudo dnf install -y fedora-workstation-repositories

#enable third party repositories
#sudo fedora-third-party enable

#install nvidia driver, nvidia settings and nvidia 32 bit support (e.g. for Steam games)
#sudo dnf -y install nvidia-driver nvidia-settings nvidia-driver-libs.i686

##########

_install() {
    _msg "Installing Nvidia driver and dependencies ..."
    #install proprietary nvidia driver and optional packages to enable cuda/nvenc
    sudo dnf install -y akmod-nvidia xorg-x11-drv-nvidia-cuda
}

_exclNouveau() {
    _msg "Disabling and uninstalling Nouveau modules/drivers ..."
    
    pkgs="xorg-x11-drv-nouveau"

    #remove nouveau driver package
    sudo dnf remove -q -y ${pkgs}

    #exclude the nouveau package from dnf install
    sudo cp /etc/dnf/dnf.conf /etc/dnf/dnf.conf.bak

    if [ $(grep -q -P '^exclude=' /etc/dnf/dnf.conf; echo $?) != "0" ]; then
      sed "/\[main\]/a exclude=${pkgs}" /etc/dnf/dnf.conf | sudo tee /etc/dnf/dnf.conf
    elif [ $(grep -q -P "^exclude=.*${pkgs}.*$" /etc/dnf/dnf.conf; echo $?) != "0" ]; then
      sed "/exclude=/s/$/ ${pkgs}/" /etc/dnf/dnf.conf | sudo tee /etc/dnf/dnf.conf
    fi

    #blacklist the nouveau module as a module and in dracut
    echo 'blacklist nouveau' | sudo tee /etc/modprobe.d/blacklist-nouveau.conf
    echo 'omit_drivers+=" nouveau "' | sudo tee /etc/dracut.conf.d/blacklist-nouveau.conf

    #backup the current initramfs
    sudo mv /boot/initramfs-$(uname -r).img /boot/initramfs-$(uname -r)-nouveau.img

    #regenerate the current initramfs
    sudo dracut -f /boot/initramfs-$(uname -r).img $(uname -r)

    #update grub config
    sudo grub2-mkconfig -o /boot/grub2/grub.cfg
}
