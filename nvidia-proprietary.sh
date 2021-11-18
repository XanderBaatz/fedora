#!/bin/sh
# wget -qO- https://git.io/J1gdu | sh

# Credits: https://gist.github.com/sebastiaanfranken/61474c1929ab256e4247a7a4a73262ca

pkgs="xorg-x11-drv-nouveau"

#remove nouveau driver package
sudo dnf remove -y ${pkgs}

#exclude the nouveau package from dnf install
sudo cp /etc/dnf/dnf.conf /etc/dnf/dnf.conf.bak

if [ $(grep -q -P '^exclude=' /etc/dnf/dnf.conf; echo $?) != "0" ]; then
  sed "/\[main\]/a exclude=${pkgs}" /etc/dnf/dnf.conf | sudo tee /etc/dnf/dnf.conf
else
  sed "/exclude=/s/$/ ${pkgs}/" /etc/dnf/dnf.conf | sudo tee /etc/dnf/dnf.conf
fi



#blacklist the nouveau module as a module and in dracut
#sudo echo 'blacklist nouveau' > /etc/modprobe.d/blacklist-nouveau.conf
#sudo echo 'omit_drivers+=" nouveau "' > /etc/dracut.conf.d/blacklist-nouveau.conf

#backup the current initramfs
#sudo mv /boot/initramfs-$(uname -r).img /boot/initramfs-$(uname -r)-nouveau.img

#regenerate the current initramfs
#sudo dracut -f /boot/initramfs-$(uname -r).img $(uname -r)

#
#sudo grub2-mkconfig -o /boot/grub2/grub.cfg

#install nvidia driver and optional packages to enable cuda/nvenc
sudo dnf install -y akmod-nvidia xorg-x11-drv-nvidia-cuda
