#!/bin/bash

CONF_FILE="shortcuts.conf"

if [ ! -f "$CONF_FILE" ]; then
    echo "Error: file $CONF_FILE not found!"
    exit 1
fi

dconf load /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/ < "$CONF_FILE"

SLOTS=$(grep -oP '(?<=^\[)custom[^\]]+' "$CONF_FILE" | sed "s#^#'/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/#; s#\$#/#'" | paste -sd, -)

gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "[$SLOTS]"

echo "Shortcuts from $CONF_FILE successfully installed"