#!/usr/bin/env bash

set -e

FONT_DIR="$HOME/.local/share/fonts"
TEMP_DIR=$(mktemp -d)

mkdir -p "$FONT_DIR"

echo "Installing fonts..."

install_font() {
    local font_name="$1"
    local font_url="$2"
    local zip_file="$TEMP_DIR/${font_name}.zip"
    local extract_dir="$TEMP_DIR/$font_name"

    echo "Loading font: $font_name..."
    curl -fLo "$zip_file" "$font_url"

    echo "Unpacking $font_name..."
    mkdir -p "$extract_dir"
    unzip -q -o "$zip_file" -d "$extract_dir"

    find "$extract_dir" -type f \( -name "*.ttf" -o -name "*.otf" \) ! -name "*Windows*" -exec cp {} "$FONT_DIR/" \;
}

install_font "JetBrainsMono" "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip"

INTER_URL=$(curl -s https://api.github.com/repos/rsms/inter/releases/latest | grep -o 'https://github.com/rsms/inter/releases/download/[^"]*Inter-[^"]*.zip' | head -n 1)
if [ -z "$INTER_URL" ]; then
    INTER_URL="https://github.com/rsms/inter/releases/download/v4.1/Inter-4.1.zip"
fi
install_font "Inter" "$INTER_URL"

echo "Cleaning up temporary files..."
rm -rf "$TEMP_DIR"

echo "Updating fontconfig font cache..."
fc-cache -fv "$FONT_DIR" > /dev/null

echo "Fonts successfully installed!"
