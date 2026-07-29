#!/bin/bash

if [ -d "dotfiles-personal/.thunderbird" ]; do
    stow "dotfiles-personal"
done
