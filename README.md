💻 stepan41k's Dotfiles (Fedora + Alacritty + Zsh)

My personal configuration files for a fast, minimalist, and productive terminal environment on Fedora Linux.

✨ Features

Terminal: Alacritty — A cross-platform, GPU-accelerated terminal emulator.

Shell: Zsh with Oh My Zsh framework.

Font: JetBrainsMono Nerd Font for perfect icon rendering and readability.

Syntax Highlighting: Real-time feedback for commands (Green = valid, Red = error).

Auto-suggestions: Fish-like completions based on your command history.

Theme: Custom Dark Theme (Tokyo Night inspired).

🚀 Quick Start

To set up this environment on a fresh Fedora installation, run the following commands (do not use sudo to run the script):

code
Bash
download
content_copy
expand_less
# Clone the repository
git clone https://github.com/stepan41k/dotfiles.git
cd dotfiles

# Make the installer executable
chmod +x install.sh

# Run the installation script
./install.sh

Note: The script will automatically install the required packages via dnf, download Nerd Fonts, set up Oh My Zsh, and create symbolic links for the configuration files.

📂 Project Structure

alacritty/ — Terminal configuration (colors, fonts, padding).

zsh/ — .zshrc config and plugin installation scripts.

fonts/ — Automated Nerd Fonts downloader and installer.

install.sh — Main installer script that ties everything together.

🛠 Management & Customization

Since the installer uses symbolic links (symlinks), any changes you make inside this repository folder will be applied to your system immediately.

Edit Alacritty settings: nano ~/dotfiles/alacritty/alacritty.toml

Edit Zsh settings: nano ~/dotfiles/zsh/.zshrc

After editing .zshrc, apply changes by running:

code
Bash
download
content_copy
expand_less
source ~/.zshrc

❓ Troubleshooting

Text issues or overlapping characters?
Ensure the font is correctly installed. Check the exact font name in your system by running:
fc-list :family | grep -i jetbrains
Make sure this name matches the family field in alacritty.toml.

Default shell didn't change?
You usually need to Log Out and Log In again for chsh to take effect. If it still shows bash, run:
chsh -s $(which zsh)

Missing Icons (Squares instead of symbols)?
Make sure your terminal is actually using the "Nerd Font" version of JetBrains Mono.