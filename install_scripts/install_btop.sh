#!/usr/bin/bash

install_btop() {

    if is_installed btop; then
        echo -e "Btop is already installed.\n"
        return 0
    fi

    echo "Installing Btop..."
    simple_install btop
    echo -e "Btop installation complete.\n"
}