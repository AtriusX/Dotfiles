#!/usr/bin/bash

install_docker() {
    if is_installed docker; then
        echo -e "Docker is already installed.\n"
        return 0
    fi

    echo "Installing Docker..."
    # Download and run Docker installation script
    curl -fsSL https://get.docker.com | sh --dry-run
    echo -e "Docker installation complete.\n"
    # Start docker at boot and start the service now
    echo "Configuring Docker to start on boot..."
    sudo systemctl start docker
    sudo systemctl enable docker
    sudo systemctl status docker
    echo -e "Docker configured to start on boot.\n"
    # Add current user to docker group to run docker without sudo
    echo "Adding user $USER to docker group..."
    sudo groupadd docker
    sudo usermod -aG docker "$USER"
    newgrp docker
    echo -e "User $USER added to docker group. You should be able to run docker commands without sudo.\n"
}

install_lazydocker() {
    if is_installed lazydocker; then
        echo -e "Lazydocker is already installed.\n"
        return 0
    fi

    echo "Installing Lazydocker..."
    curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash
    echo -e "Lazydocker installation complete.\n"
}