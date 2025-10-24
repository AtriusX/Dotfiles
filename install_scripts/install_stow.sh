#!/usr/bin/bash

install_stow() {
    echo "Installing Stow..."

    if is_installed stow; then
        echo -e "Stow is already installed. Skipping installation.\n"
        return 0
    fi

    simple_install stow
    echo -e "Stow installation complete.\n"

    stow_configs
}

stow_configs() {
    if stow .; then
        echo -e "Stow operation completed successfully.\n"
    fi

    echo "Stow encountered an error during initial stow."
    echo "You can force the operation by typing 'force', otherwise hit enter to skip and you can stow manually later."
    echo -e "This will cause any local changes to be lost, so only do this if you are sure you want to overwrite your local configs!\n"
    
    echo -n "Type 'force' to proceed: "
    read -r force

    if [ "${force,,}" == "force" ]; then
        echo "Forcing stow operation..."
        stow --adopt .
        git reset --hard origin/main
    fi

    echo -e "Stow operation complete. Configurations have been overwritten.\n"
}