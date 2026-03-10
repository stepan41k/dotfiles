#!/bin/bash

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

install_or_update() {
    local repo_url=$1
    local dest_dir=$2
    if [ -d "$dest_dir" ]; then
        echo "Updating $(basename $dest_dir)..."
        git -C "$dest_dir" pull
    else
        echo "Installing $(basename $dest_dir)..."
        git clone "$repo_url" "$dest_dir"
    fi
}

install_or_update "https://github.com/zsh-users/zsh-autosuggestions" "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
install_or_update "https://github.com/zsh-users/zsh-syntax-highlighting.git" "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"

echo "All plugins Zsh actual."