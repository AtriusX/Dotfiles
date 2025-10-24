#!/usr/bin/bash

install_starship() {
    echo "Installing Starship prompt..."

    if is_installed starship; then
        echo -e "Starship is already installed. Skipping installation.\n"
        return 0
    fi

    curl -sS https://starship.rs/install.sh | sh
    echo -e "Starship installation complete.\n"
}

install_nushell() {
    local os=$OS_TYPE

    echo "Installing Nushell for $os..."
    
    if is_installed nu; then
        echo -e "Nushell is already installed. Skipping installation.\n"
        return 0
    fi

    case $os in
        "ubuntu" | "debian")
            curl -fsSL https://apt.fury.io/nushell/gpg.key | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/furyushell.gpg
            echo "deb https://apt.fury.io/nushell/ /" | sudo tee /etc/apt/sources.list.d/fury.list
            sudo apt update
        ;;

        "fedora")
            echo "[gemfuryushell]
            name=Gemfury Nushell Repo
            baseurl=https://yum.fury.io/nushell/
            enabled=1
            gpgcheck=0
            gpgkey=https://yum.fury.io/nushell/gpg.key" | sudo tee /etc/yum.repos.d/furyushell.repo
        ;;

        *)
            echo "OS not supported for automatic Nushell installation. Please install it manually."
            return 1
        ;;
    esac
    
    simple_install nushell
    echo -e "Nushell installation complete.\n"
}

install_zoxide() {
    echo "Installing Zoxide..."

    if is_installed zoxide; then
        echo -e "Zoxide is already installed. Skipping installation.\n"
        return 0
    fi

    curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
    echo -e "Zoxide installation complete.\n"
}

install_shell() {
    install_starship
    install_nushell
    install_zoxide

    echo "Changing shell to Nushell... Enter your password if prompted."
    chsh -s "$(which nu)"
    echo "Shell changed to $SHELL successfully."
    echo -e "Restart your terminal or enter 'nu' to start using Nushell. It will be the default shell on your next login.\n"
}