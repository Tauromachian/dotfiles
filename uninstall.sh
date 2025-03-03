#!/bin/bash

stow_folders=("bash" "home")

for stow_folder in "${stow_folders[@]}"; do
    stow -D "$stow_folder"
done
