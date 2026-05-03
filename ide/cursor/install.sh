#!/bin/bash

BIN_DIR="$HOME/.local/bin"
ICON_DIR="$HOME/.local/share/icons"
APP_DIR="$HOME/.local/share/applications"
DOTFILES_DIR="$(pwd)"

mkdir -p "$BIN_DIR"
mkdir -p "$ICON_DIR"
mkdir -p "$APP_DIR"

echo "Downloading Cursor icon..."
curl -L https://raw.githubusercontent.com/getcursor/cursor/main/assets/icon.png -o "$ICON_DIR/cursor-icon.png"

sed "s/%u/$USER/g" "$DOTFILES_DIR/cursor.desktop" > "$APP_DIR/cursor.desktop"

if [ -f "$BIN_DIR/cursor.appimage" ]; then
    chmod +x "$BIN_DIR/cursor.appimage"
    echo "Access rights to AppImage set."
else
    echo "ATTENTION: remove cursor.appimage to $BIN_DIR"
fi

echo "Installation complete! Cursor installed."