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

stow_configs() {
    if stow .; then
        echo "Stow operation completed successfully."
    fi

    echo "Stow encountered an error during initial stow."
    echo "You can force the operation by typing 'force', otherwise hit enter to skip and you can stow manually later."
    echo "This will cause any local changes to be lost, so only do this if you are sure you want to overwrite your local configs!"
    
    read -r force

    if [ "${force,,}" == "force" ]; then
        echo "Forcing stow operation..."
        stow --adopt .
        git reset --hard origin/main
    fi

    echo "Stow operation complete. Configurations have been overwritten."
}