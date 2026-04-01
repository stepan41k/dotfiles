#bin/sh

# Download
sudo rpm -v --import https://download.sublimetext.com/sublimehq-rpm-pub.gpg

# Add repo
sudo dnf config-manager --add-repo https://download.sublimetext.com/sublimehq-fedora.repo

# Install
sudo dnf install sublime-text