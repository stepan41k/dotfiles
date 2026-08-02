#!/bin/bash

CONF_FILE="shortcuts.conf"

if [ ! -f "$CONF_FILE" ]; then
    echo "ERROR: file $CONF_FILE not found!"
    exit 1
fi

dconf load /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/ < "$CONF_FILE"

SLOTS=""
for section in $(grep -E '^\[custom' "$CONF_FILE" | tr -d '[]'); do
    SLOTS="${SLOTS}'/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/${section}/', "
done

SLOTS="[${SLOTS%, }]"

gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "$SLOTS"

echo "Shortcuts from $CONF_FILE successfully installed"
