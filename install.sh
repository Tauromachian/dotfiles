#!/bin/bash

if ! command -v ansible > /dev/null 2>&1; then
    sudo apt install software-properties-common
    sudo apt-add-repository --yes --update ppa:ansible/ansible
    sudo apt install ansible
fi
