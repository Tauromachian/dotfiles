#!/bin/bash

#Install timeshift
sudo add-apt-repository ppa:teejee2008/ppa
sudo apt-get update
sudo apt-get install timeshift -y

#Install docker
# sudo apt-get update

# sudo apt-get install \
#     apt-transport-https \
#     ca-certificates \
#     curl \
#     gnupg-agent \
#     software-properties-common

# curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# sudo apt-key fingerprint 0EBFCD88

# sudo add-apt-repository \
#    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
#    $(lsb_release -cs) \
#    stable"
   
# sudo apt-get update

# sudo apt-get install docker-ce docker-ce-cli containerd.io

sudo apt-get update
sudo apt-get -y install podman

#Install brave web browser
curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add -

echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list

sudo apt update

sudo apt install -y brave-browser

#Samba share
sudo apt-get update
sudo apt-get install -y samba --install-recommends

#Timeshift
#sudo apt-add-repository -y ppa:teejee2008/ppa
#sudo apt-get update

# APT
sudo apt-get -y install gpick

#Gaming
sudo dpkg --add-architecture i386 
wget -nc https://dl.winehq.org/wine-builds/winehq.key
sudo apt-key add winehq.key
sudo apt-get update
sudo apt install -y --install-recommends winehq-stable

sudo add-apt-repository ppa:lutris-team/lutris
sudo apt update
sudo apt install -y lutris

z
#Flatpak applications
flatpak install flathub org.videolan.VLC -y
flatpak install flathub com.obsproject.Studio -y
flatpak install flathub org.shotcut.Shotcut -y
flatpak install flathub nl.hjdskes.gcolor3 -y
flatpak install flathub com.calibre_ebook.calibre -y
flatpak install flathub com.valvesoftware.Steam -y
flatpak install flathub org.telegram.desktop

#Snap applications
#sudo snap install vlc
sudo snap install insomnia
sudo snap install discord
