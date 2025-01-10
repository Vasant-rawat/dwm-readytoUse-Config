#!/bin/bash

# Exit on error
set -e

# Function to install dwm
install_dwm() {
    echo "Cleaning previous builds..."
    make clean

    echo "Building and installing dwm..."
    sudo make install

    echo "dwm installed successfully!"
}

# Function to restart dwm
restart_dwm() {
    echo "Restarting dwm..."
    if pkill dwm; then
        echo "dwm restarted successfully."
    else
        echo "Failed to restart dwm. Make sure dwm is running."
    fi
}

# Main function
main() {
    echo "Starting dwm installation..."
    cd ./dwm || { echo "Error: dwm directory not found."; exit 1; }
    install_dwm
    restart_dwm
}

# Run the script
main
