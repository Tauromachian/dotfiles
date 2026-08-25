#!/bin/bash

git submodule update --init --recursive

if [ -d "dotfiles-personal/.thunderbird" ]; then
    stow "dotfiles-personal"
fi
