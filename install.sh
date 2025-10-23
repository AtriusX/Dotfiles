#!/usr/bin/bash

OS_TYPE=$(grep -oP '^ID=\K[^"]+' /etc/os-release)

# shellcheck source=/dev/null
source install_scripts/install_shell.sh
# shellcheck source=/dev/null
source install_scripts/install_stow.sh

install_shell "$OS_TYPE"

install_stow "$OS_TYPE"

stow .