#!/bin/bash

config_paths=("$HOME/.bashrc" "$HOME/.bash_aliases" "$HOME/.tmux.conf" "$HOME/.config/ghostty" "$HOME/.config/nvim" "$HOME/.config/alacritty")

rm -rf "${config_paths[@]}"

stow_folders=("bash" "zsh" "home")

for stow_folder in "${stow_folders[@]}"; do
    stow "$stow_folder"
done
