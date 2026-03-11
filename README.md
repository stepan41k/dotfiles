# 💻 Stepan41k's Dotfiles (Fedora + Alacritty + Zsh)

My personal configuration files for a fast, minimalist, and productive terminal environment on Fedora Linux.

## ✨ Features

- **Terminal:** [Alacritty](https://github.com/alacritty/alacritty) — GPU-accelerated terminal emulator.
- **Shell:** [Zsh](https://www.zsh.org/) with [Oh My Zsh](https://ohmyz.sh/) framework.
- **Font:** [JetBrainsMono Nerd Font](https://www.nerdfonts.com/) for perfect icon rendering.
- **Syntax Highlighting:** Real-time feedback (Green = valid, Red = error).
- **Auto-suggestions:** Completions based on your command history.

## 🚀 Quick Start

To set up this environment on a fresh **Fedora** installation, run the following commands (do **not** use `sudo` for the script itself):

```bash
# 1. Clone the repository
git clone https://github.com/stepan41k/dotfiles.git
cd dotfiles

# 2. Make the installer executable
chmod +x install.sh

# 3. Run the installation script
./install.sh

```

Note: The script installs required packages via dnf, downloads Nerd Fonts, sets up Oh My Zsh, and creates symbolic links for the configuration files.
📂 Project Structure
alacritty/ — Terminal configuration (colors, fonts, padding).
zsh/ — .zshrc config and plugin installation scripts.
fonts/ — Automated Nerd Fonts installer.
install.sh — Main installer script.
🛠 Management & Customization
Since the installer uses symbolic links, any changes you make inside this repository folder will be applied to your system immediately.
Edit Alacritty: nano ~/dotfiles/alacritty/alacritty.toml
Edit Zsh: nano ~/dotfiles/zsh/.zshrc

Apply Zsh changes:

```bash
source ~/.zshrc

```

❓ Troubleshooting
Text issues? Check font name: fc-list :family | grep -i jetbrains. It must match the name in alacritty.toml.
Shell not changing? Log out and Log in again. If needed, run: chsh -s $(which zsh).
Missing Icons? Ensure you are using the "Nerd Font" version of JetBrains Mono.


