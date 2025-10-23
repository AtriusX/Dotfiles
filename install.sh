#!/usr/bin/bash

# Check for curl installation
if [[ -z "$(type -t curl)" ]]; then
    echo "Cannot continue because curl is not installed. Please install curl and re-run this script."
    return 1
fi
# Get OS ID from /etc/os-release
OS_TYPE=$(grep -oP '^ID=\K[^"]+' /etc/os-release)

# shellcheck source=/dev/null
source install_scripts/install_shell.sh
# shellcheck source=/dev/null
source install_scripts/install_stow.sh
# Install shell environment
install_shell "$OS_TYPE"
# Install and apply stow
install_stow "$OS_TYPE"
stow_configs