#!/usr/bin/bash

install_tmux() {
    if is_installed tmux; then
        echo -e "Tmux is already installed.\n"
        return 0
    fi

    echo "Installing Tmux..."
    simple_install tmux
    echo -e "Tmux installation complete.\n"
}