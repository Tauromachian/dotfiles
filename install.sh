#!/bin/bash

stow_folders=("bash" "home" "redshift")

for stow_folder in "${stow_folders[@]}"; do
    stow "$stow_folder"
done
