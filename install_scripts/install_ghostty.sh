#!/usr/bin/bash

install_ghostty() {

    if is_installed ghostty; then
        echo -e "Ghostty is already installed. Skipping.\n"
        return
    fi

    echo "Installing Ghostty..."
    case $OS_TYPE in
        "debian" | "ubuntu")
            curl -sS https://debian.griffo.io/EA0F721D231FDD3A0A17B9AC7808B4DD62C41256.asc | \
                gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/debian.griffo.io.gpg
            echo "deb https://debian.griffo.io/apt $(lsb_release -sc 2>/dev/null) main" | \
                sudo tee /etc/apt/sources.list.d/debian.griffo.io.list
        ;;

        "fedora")
            sudo dnf copr enable scottames/ghostty
        ;;
    esac

    simple_install ghostty
    echo -e "Ghostty installation complete.\n"
}