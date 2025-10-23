#!/usr/bin/bash

install_stow() {
    local os=$1
    
    echo "Installing Stow..."

    if [ "$(type -t stow)" ]; then
        echo "Stow is already installed. Skipping installation."
        return 0
    fi

    case $os in
        "ubuntu" | "debian")
            sudo apt install -y stow
        ;;

        "fedora")
            sudo dnf install -y stow
        ;;

        *)
            echo "OS not supported for automatic Stow installation. Please install it manually."
            return 1
        ;;
    esac

    echo "Stow installation complete."
}