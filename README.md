# Dotfiles

Personal development environment configuration for Fedora Linux.

## Overview

This repository contains my personal dotfiles and configuration scripts for setting up a complete development environment, including:

- **Shell**: Zsh with Oh My Zsh, autosuggestions, and syntax highlighting
- **Terminal**: Alacritty and Ghostty configurations
- **Git**: Optimized Git configuration with aliases and diff settings
- **IDEs**: Cursor and Zed editor configurations
- **Fonts**: JetBrainsMono Nerd Font installation

## Quick Start

Run the installation script to set up everything automatically:

```bash
./install.sh
```

The script will:
1. Install required packages (alacritty, zsh, git, curl, unzip, fontconfig)
2. Install JetBrainsMono Nerd Font
3. Install Oh My Zsh if not present
4. Install Zsh plugins (autosuggestions, syntax-highlighting)
5. Copy configuration files to appropriate locations
6. Set Zsh as the default shell

## Structure

```
.
├── install.sh              # Main installation script
├── git/
│   └── config              # Git configuration
├── zsh/
│   ├── .zshrc              # Zsh shell configuration
│   └── install_plugins.sh  # Zsh plugins installer
├── terminal/
│   ├── alacritty/          # Alacritty terminal config
│   │   ├── alacritty.toml
│   │   └── themes/
│   └── ghostty/            # Ghostty terminal config
│       ├── config
│       └── themes/
├── ide/
│   ├── cursor/             # Cursor IDE configuration
│   │   ├── cursor_user_config.json
│   │   ├── cursor.desktop
│   │   ├── install.sh
│   │   └── manual.md
│   └── zed/                # Zed editor configuration
│       ├── config.json
│       └── install.sh
├── other/
│   └── fonts/
│       └── install_fonts.sh # Font installation script
├── utils/                  # Utility scripts and configs
└── warp/                   # Warp terminal configs
```

## Components

### Git Configuration

Located in `git/config`, includes:
- Default branch set to `main`
- Histogram diff algorithm with external `difft` tool
- Fast-forward only pulls
- Auto-setup remote on push
- `git graph` alias for visual log

### Zsh Configuration

Located in `zsh/.zshrc`, features:
- Oh My Zsh with `robbyrussell` theme
- Plugins: git, zsh-autosuggestions, zsh-syntax-highlighting, sudo
- Tokyo Night color scheme for syntax highlighting
- Custom aliases for ls, Docker, Go, and config management
- Golang environment setup

### Terminal Emulators

**Alacritty** (`terminal/alacritty/alacritty.toml`):
- JetBrainsMono Nerd Font at 12pt
- Block cursor with blinking
- Window padding and transparency

**Ghostty** (`terminal/ghostty/config`):
- JetBrainsMono Nerd Font at 10pt with ligatures
- Hatsunemiku theme
- Custom keybindings for tabs, splits, and navigation
- Window padding and blur effects

### IDE Configurations

**Cursor** (`ide/cursor/`):
- Tokyo Night Storm theme
- Prettier formatting (tabs, no semicolons, single quotes)
- Go, SQL, and Protobuf tooling
- File nesting and minimap settings
- GitHub Copilot disabled by default

**Zed** (`ide/zed/config.json`):
- Catppuccin Mocha theme and icons
- Cursor keymap
- AI agent integration (Gemini, OpenCode, Qwen)
- Auto-save, soft wrap, linked edits
- Left-docked panels

## Manual Setup

If you prefer to install components individually:

### Install Fonts

```bash
chmod +x other/fonts/install_fonts.sh
./other/fonts/install_fonts.sh
```

### Install Zsh Plugins

```bash
chmod +x zsh/install_plugins.sh
./zsh/install_plugins.sh
```

### Setup Git Config

```bash
cp git/config ~/.gitconfig
```

### Setup Terminal Configs

```bash
mkdir -p ~/.config/alacritty
cp terminal/alacritty/alacritty.toml ~/.config/alacritty/alacritty.toml

mkdir -p ~/.config/ghostty
cp terminal/ghostty/config ~/.config/ghostty/config
```

## Requirements

- Fedora Linux (uses `dnf` package manager)
- Non-root user (script will refuse to run as root)

## Notes

- After running `install.sh`, restart your terminal or run `exec zsh`
- Some IDE configs may contain machine-specific paths that need adjustment
- The `warp/` directory is currently empty, reserved for future Warp terminal config
