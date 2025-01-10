#!/bin/sh

# Exit on error
set -e

# Install dwm, dmenu, and dwmblocks
install_suckless_tools() {
    echo "Installing dwm..."
    (cd ./dwm && sudo make clean install)

    echo "Installing dmenu..."
    (cd ./dmenu && sudo make clean install)

    echo "Installing dwmblocks..."
    (cd ./dwmblocks && sudo make clean install)
}

# Download and install JetBrains Mono font
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
    sudo mv "$FONT_ZIP.tmp/fonts/ttf/*.ttf" "$FONT_DIR/"

    echo "Updating font cache..."
    sudo fc-cache -fv

    echo "Cleaning up..."
    rm -rf "$FONT_ZIP" "$FONT_ZIP.tmp"
}

# Rebuild dwm (if needed)
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
    install_suckless_tools
    install_fonts
    rebuild_dwm
    echo "Installation complete!"
}

# Run the script
main
