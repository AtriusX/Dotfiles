#!/usr/bin/bash

# shellcheck source=/dev/null
source ./install_scripts/utils/simple_install.sh
source ./install_scripts/utils/is_installed.sh
source ./install_scripts/install_stow.sh

# Check for curl installation
if ! is_installed curl; then
    echo "Cannot continue because curl is not installed. Please install curl and re-run this script."
    return 1
fi
# Help message
list_help() {
    echo "

    Atri's Dotfiles Installer Script

    Usage: ./install.sh [OPTIONS]

    Options:
        --help) Display this help message.
        --shell) Install shell environment (Starship, Nushell, Zoxide).
        --docker) Installs Docker Engine and configures it to the environment.
        --btop) Installs the Btop system monitor.
        --micro) Installs the Micro text editor.
        --tmux) Installs the Tmux terminal multiplexer.
    "
}
# Install all requested components
for arg in "$@"; do
    case $arg in
        --help | -h)
            list_help
            exit 0
        ;;

        --shell)
            source ./install_scripts/install_shell.sh
            install_shell
        ;;

        --docker)
            source ./install_scripts/install_docker.sh
            install_docker
            install_lazydocker
        ;;

        --btop)
            source ./install_scripts/install_btop.sh
            install_btop
        ;;

        --micro)
            source ./install_scripts/install_micro.sh
            install_micro
        ;;

        --tmux)
            source ./install_scripts/install_tmux.sh
            install_tmux
        ;;

        *)
            echo "Unknown option: $arg"
            list_help
            exit 1
        ;;
    esac
done
# Install stow after completion
install_stow

echo -e "----------------------------------------\n"
echo "Installation script completed."