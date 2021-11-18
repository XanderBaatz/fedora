#!/bin/sh
# wget -qO- https://git.io/XXXXX | sh

#install nvidia driver and optional packages to enable cuda/nvenc
sudo dnf install -y akmod-nvidia xorg-x11-drv-nvidia-cuda
