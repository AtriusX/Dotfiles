#!/usr/bin/bash

install_posting() {

    if is_installed posting; then
        echo -e "Posting HTTP Client is already installed. Skipping.\n"
        return
    fi

    echo "Installing Posting HTTP Client..."
    curl -LsSf https://astral.sh/uv/install.sh | sh
    uv tool install --python 3.12 posting
    echo -e "Posting installation complete.\n"
}