#!/bin/bash

if [ -d "dotfiles-personal/.thunderbird" ]; then
    stow "dotfiles-personal"
fi
