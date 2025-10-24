#!/usr/bin/bash

# Get OS ID from /etc/os-release
OS_TYPE=$(grep -oP '^ID=\K[^"]+' /etc/os-release)

simple_install() {

    local pkg=$1

    case $OS_TYPE in
        "ubuntu" | "debian")
            sudo apt install -y "$pkg"
        ;;

        "fedora")
            sudo dnf install -y "$pkg"
        ;;

        *)
            echo "Cannot execute installation for Unsupported OS. Please install $pkg manually."
            return 1
        ;;
    esac
}