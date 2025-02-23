#!/bin/bash

stow_folders=("bash" "home")

for stow_folder in "${stow_folders[@]}"; do
    stow "$stow_folder"
done
