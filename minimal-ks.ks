# Fedora version: $releasever
# Fedora architecture: $basearch
#version=DEVEL
# Use graphical install
graphical

# repo - Configure Additional Repositories
#repo --name=rpmfusion-free --mirrorlist="https://mirrors.rpmfusion.org/mirrorlist?repo=free-fedora-$releasever&arch=$basearch" --cost=0
#repo --name=rpmfusion-free-updates --mirrorlist="https://mirrors.rpmfusion.org/mirrorlist?repo=free-fedora-updates-released-$releasever&arch=$basearch" --cost=0
#repo --name=rpmfusion-nonfree --mirrorlist="https://mirrors.rpmfusion.org/mirrorlist?repo=nonfree-fedora-$releasever&arch=$basearch" --cost=0
#repo --name=rpmfusion-nonfree-updates --mirrorlist="https://mirrors.rpmfusion.org/mirrorlist?repo=nonfree-fedora-updates-released-$releasever&arch=$basearch" --cost=0

# Packages
%packages
@^minimal-environment
@standard
@hardware-support
@networkmanager-submodules
@multimedia
@critical-path-gnome --nodefaults
initial-setup
%end

# Run the Setup Agent on first boot
firstboot --enable
