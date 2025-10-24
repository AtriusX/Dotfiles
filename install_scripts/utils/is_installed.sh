#!/usr/bin/bash

is_installed() {
    local cmd=$1

    if [ "$(type -t "$cmd")" ]; then
        return 0
    else
        return 1
    fi
}