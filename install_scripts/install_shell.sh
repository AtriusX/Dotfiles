#!/usr/bin/bash

install_starship() {
    echo "Installing Starship prompt..."

    if [ "$(type -t starship)" ]; then
        echo "Starship is already installed. Skipping installation."
        return 0
    fi

    curl -sS https://starship.rs/install.sh | sh
    echo "Starship installation complete."
}

install_nushell() {
    local os=$1

    echo "Installing Nushell for $os..."
    
    if [ "$(type -t nu)" ]; then
        echo "Nushell is already installed. Skipping installation."
        return 0
    fi

    case $os in
        "ubuntu" | "debian")
            curl -fsSL https://apt.fury.io/nushell/gpg.key | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/fury-nushell.gpg
            echo "deb https://apt.fury.io/nushell/ /" | sudo tee /etc/apt/sources.list.d/fury.list
            sudo apt update
            sudo apt install nushell
        ;;

        "fedora")
            echo "[gemfury-nushell]
            name=Gemfury Nushell Repo
            baseurl=https://yum.fury.io/nushell/
            enabled=1
            gpgcheck=0
            gpgkey=https://yum.fury.io/nushell/gpg.key" | sudo tee /etc/yum.repos.d/fury-nushell.repo
            sudo dnf install -y nushell
        ;;

        *)
            echo "OS not supported for automatic Nushell installation. Please install it manually."
            return 1
        ;;
    esac

    echo "Nushell installation complete."
}

install_zoxide() {
    echo "Installing Zoxide..."

    if [ "$(type -t zoxide)" ]; then
        echo "Zoxide is already installed. Skipping installation."
        return 0
    fi

    curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
    echo "Zoxide installation complete."
}

install_shell() {
    install_starship
    echo

    install_nushell "$1"
    echo

    install_zoxide
    echo

    echo "Changing shell to Nushell... Enter your password if prompted."
    chsh -s "$(which nu)"
    echo

    echo "Shell changed to $SHELL successfully."
    echo "Restart your terminal or enter 'nu' to start using Nushell. It will be the default shell on your next login."
}