#!/usr/bin/bash

install_micro() {
    if is_installed micro; then
        echo -e "Micro is already installed.\n"
        return 0
    fi

    echo "Installing Micro..."
    simple_install micro
    echo -e "Micro installation complete.\n"
}