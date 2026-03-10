#!/bin/bash

if [ "$EUID" -eq 0 ]; then 
  echo "Please, do not run this script as root or sudo.."
  exit
fi

echo "Starting installation of configs..."

sudo dnf install -y alacritty zsh git curl unzip fontconfig

chmod +x fonts/install_fonts.sh
./fonts/install_fonts.sh

if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"

chmod +x zsh/install_plugins.sh
./zsh/install_plugins.sh


echo "Copying configs..."
mkdir -p ~/.config/alacritty

# ln -sf "$(pwd)/alacritty/alacritty.toml" "$HOME/.config/alacritty/alacritty.toml"
# ln -sf "$(pwd)/zsh/.zshrc" "$HOME/.zshrc"

cp alacritty/alacritty.toml ~/.config/alacritty/alacritty.toml
cp zsh/.zshrc ~/.zshrc

if [ "$SHELL" != "$(which zsh)" ]; then
    echo "Changing the shell to zsh..."
    chsh -s $(which zsh)
fi

echo "Done! Restart Alacritty."