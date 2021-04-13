#!/bin/bash

#Install flatpak
sudo rm /etc/apt/preferences.d/nosnap.pref
sudo apt update
sudo apt install -y snapd
