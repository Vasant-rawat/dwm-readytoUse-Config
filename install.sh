#!/bin/sh

# Exit on error
set -e

# Function to check and install dependencies
install_dependencies() {
    echo "Checking for required dependencies..."

    # List of required packages
    DEPENDENCIES="build-essential libx11-dev libxft-dev libxinerama-dev wget unzip"

    # Check if each dependency is installed
    for pkg in $DEPENDENCIES; do
        if ! dpkg -l | grep -q "^ii  $pkg "; then
            echo "Installing $pkg..."
            sudo apt-get install -y "$pkg"
        else
            echo "$pkg is already installed."
        fi
    done

    echo "All dependencies are installed."
}

# Function to install dwm, dmenu, and dwmblocks
install_suckless_tools() {
    echo "Installing dwm..."
    (cd ./dwm && sudo make clean install)

    echo "Installing dmenu..."
    (cd ./dmenu && sudo make clean install)

    echo "Installing dwmblocks..."
    (cd ./dwmblocks && sudo make clean install)
}

# Function to download and install JetBrains Mono font
install_fonts() {
    FONT_URL="https://github.com/JetBrains/JetBrainsMono/releases/download/v2.304/JetBrainsMono-2.304.zip"
    FONT_ZIP="JetBrainsMono-2.304.zip"
    FONT_DIR="/usr/share/fonts/truetype/JetBrainsMono"

    echo "Downloading JetBrains Mono font..."
    wget -q "$FONT_URL" -O "$FONT_ZIP"

    echo "Unzipping font..."
    unzip -q "$FONT_ZIP" -d "$FONT_ZIP.tmp"

    echo "Installing font..."
    sudo mkdir -p "$FONT_DIR"
    sudo mv "$FONT_ZIP.tmp/fonts/ttf/"*.ttf "$FONT_DIR/"

    echo "Updating font cache..."
    sudo fc-cache -fv

    echo "Cleaning up..."
    rm -rf "$FONT_ZIP" "$FONT_ZIP.tmp"
}

# Function to rebuild dwm (if needed)
rebuild_dwm() {
    if [ -f "./rebuild_dwm.sh" ]; then
        echo "Rebuilding dwm..."
        ./rebuild_dwm.sh
    else
        echo "rebuild_dwm.sh not found. Skipping..."
    fi
}

# Main function
main() {
    install_dependencies
    install_suckless_tools
    install_fonts
    rebuild_dwm
    echo "Installation complete!"
}

# Run the script
main
