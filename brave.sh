#!/bin/sh
# wget -qO- https://git.io/JXr5G | sh
# curl -fsSL https://git.io/JXr5G | sh

sudo sh -c "cat << EOF > /etc/yum.repos.d/brave-browser.repo
[brave-browser]
name=Brave Browser
baseurl=https://brave-browser-rpm-release.s3.brave.com/x86_64/
skip_if_unavailable=True
gpgcheck=1
gpgkey=https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
enabled=1
EOF"

sudo sh -c "cat << EOF > /usr/lib/fedora-third-party/conf.d/brave-browser.conf
[brave-browser]
type=dnf
EOF"

#[brave-browser-rpm-release.s3.brave.com_x86_64_]
#name=created by dnf config-manager from https://brave-browser-rpm-release.s3.brave.com/x86_64/
#baseurl=https://brave-browser-rpm-release.s3.brave.com/x86_64/
#enabled=1

#sudo dnf install dnf-plugins-core -y

#sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/x86_64/

#sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc

#sudo dnf install brave-browser -y
