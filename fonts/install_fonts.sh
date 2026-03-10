#!/bin/bash

FONT_NAME="JetBrainsMono"
URL="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/${FONT_NAME}.zip"
FONT_DIR="$HOME/.local/share/fonts"

echo "Installing font Nerd Fonts..."

mkdir -p "$FONT_DIR"

TEMP_DIR=$(mktemp -d)
echo "Downloading $FONT_NAME to $TEMP_DIR..."
curl -L $URL -o "$TEMP_DIR/$FONT_NAME.zip"

unzip "$TEMP_DIR/$FONT_NAME.zip" -d "$FONT_DIR"

rm -rf "$FONT_DIR/"*Windows*
rm -rf "$TEMP_DIR"

echo "Updating cache fonts..."
fc-cache -fv

echo "Fonts intalled successfully!"