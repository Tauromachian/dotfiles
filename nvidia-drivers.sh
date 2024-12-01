#!/bin/bash

if lspci | grep -i nvidia >/dev/null 2>&1; then
    echo "NVIDIA hardware detected"
    if command -v nvidia-smi >/dev/null 2>&1; then
        echo "NVIDIA drivers are installed"
        nvidia-smi
    else
        echo "NVIDIA hardware found but drivers are not installed"
    fi
else
    echo "No NVIDIA hardware found"
fi
