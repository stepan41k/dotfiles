#bin/sh
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrep

flatpak install flathub it.mijorus.gearlever

flatpak run it.mijorus.gearlever