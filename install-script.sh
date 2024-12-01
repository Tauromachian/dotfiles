#!/bin/bash

sudo apt install -y gpick
sudo apt install -y gnome-boxes
sudo apt install -y tmux
sudo apt install -y nala
sudo apt install -y samba
sudo apt install -y curl

#Install brave web browser
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg

echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list

sudo apt update

sudo apt install brave-browser


# Starship prompt install
curl -sS https://starship.rs/install.sh | sh

#Gaming
sudo dpkg --add-architecture i386 
sudo mkdir -pm755 /etc/apt/keyrings
sudo wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key
sudo wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/jammy/winehq-jammy.sources
sudo apt install --install-recommends winehq-stable

sudo add-apt-repository ppa:lutris-team/lutris
sudo apt update
sudo apt install -y lutris


#Flatpak applications
flatpak install flathub org.videolan.VLC -y
flatpak install flathub com.obsproject.Studio -y
flatpak install flathub org.shotcut.Shotcut -y
flatpak install flathub com.calibre_ebook.calibre -y
flatpak install flathub com.valvesoftware.Steam -y
flatpak install flathub org.telegram.desktop
flatpak install flathub com.discordapp.Discord

#Install brew if is not installed
if ! command -v brew > /dev/null 2>&1; then
    echo 'Installing brew'

    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "Homebrew is already installed"
fi

#Brew installs
brew install podman
brew install neovim
