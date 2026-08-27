#!/usr/bin/env bash

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

success() {
    echo -e "${GREEN}[OK]${NC} $1"
}

warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

link_file() {
    local src="$1"
    local dest="$2"

    mkdir -p "$(dirname "$dest")"

    if [ -e "$dest" ] || [ -L "$dest" ]; then
        if [ "$(readlink "$dest")" = "$src" ]; then
            info "The symlink for $dest is already set up."
            return 0
        else
            warn "The file $dest already exists. Creating a backup at ${dest}.backup."
            mv "$dest" "${dest}.backup"
        fi
    fi

    ln -s "$src" "$dest"
    success "Symlink created: $dest -> $src"
}

# Git
setup_git() {
    info "Configuring Git..."

    local git_src=""
    if [ -f "$DOTFILES_DIR/git/.config" ]; then
        git_src="$DOTFILES_DIR/git/.config"
    elif [ -f "$DOTFILES_DIR/git/config" ]; then
        git_src="$DOTFILES_DIR/git/config"
    else
        warn "The gitconfig file was not found in the $DOTFILES_DIR/git folder"
        return 1
    fi

    link_file "$git_src" "$HOME/.gitconfig"

    if [ -f "$DOTFILES_DIR/git/.gitignore_global" ]; then
        link_file "$DOTFILES_DIR/git/.gitignore_global" "$HOME/.gitignore_global"
    fi
}

#IDE/Zed
setup_ide() {
    info "Configuring Zed IDE"

    local zed_dir="$DOTFILES_DIR/ide/zed"

    if command -v zed &> /dev/null; then
        info "Zed is already installed"
    else
        info "Zed installation..."
        if [ -f "$zed_dir/install.sh" ]; then
            bash "$zed_dir/install.sh"
            success "Zed has been successfully installed"
        else
            warn "Script $zed_dir/install.sh not found"
        fi
    fi

    if [ -f "$zed_dir/config.json" ]; then
        link_file "$zed_dir/config.json" "$HOME/.config/zed/settings.json"
    elif [ -f "$zed_dir/settings.json" ]; then
        link_file "$zed_dir/settings.json" "$HOME/.config/zed/settings.json"
    else
        warn "Config for Zed not found in $zed_dir"
    fi
}

#OS/Fedora
setup_fedora_shortcuts() {
    info "Configuring OS parameters..."

      local fedora_dir="$DOTFILES_DIR/os/fedora"

      if [ -f "$fedora_dir/shortcuts.sh" ]; then
          if command -v dconf &> /dev/null && command -v gsettings &> /dev/null; then
              info "Using GNOME/Fedora shortcuts..."
              (cd "$fedora_dir" && bash shortcuts.sh)
              success "Fedora shortcuts applied"
          else
              warn "dconf or gsettings not found. Skipping shortcut configuration."
          fi
      fi
}

# Fonts
setup_fonts() {
    info "Font settings"

    local fonts_install_script="$DOTFILES_DIR/other/fonts/install.sh"

    local jb_installed=false
    local inter_installed=false

    if command -v fc-list &> /dev/null; then
        if fc-list : family | grep -iq "JetBrainsMono"; then
            jb_installed=true
        fi
        if fc-list : family | grep -iq "Inter"; then
            inter_installed=true
        fi
    fi

    if [ "$jb_installed" = true ] && [ "$inter_installed" = true ]; then
        info "Fonts are already installed on the system"
    else
        if [ -f "$fonts_install_script" ]; then
            info "Installing missing fonts..."
            bash "$fonts_install_script"
            success "Fonts successfully installed"
        else
            warn "Script $fonts_install_script not found"
        fi
    fi
}

# zsh
setup_zsh() {
    info "Configuring Zsh..."

    local zsh_dir="$DOTFILES_DIR/zsh"

    if [ -f "$zsh_dir/install.sh" ]; then
        bash "$zsh_dir/install.sh"
    fi

    if [ -f "$zsh_dir/.zshrc" ]; then
        info "Linking user .zshrc..."
        link_file "$zsh_dir/.zshrc" "$HOME/.zshrc"
        success "The .zshrc config has been successfully updated"
    elif [ -f "$zsh_dir/zshrc" ]; then
        info "Linking user zshrc..."
        link_file "$zsh_dir/zshrc" "$HOME/.zshrc"
        success "The .zshrc config has been successfully updated"
    else
        warn "The .zshrc file was not found in $zsh_dir."
    fi
}

# Utils
setup_utils() {
    info "Installing utilities and applications..."

    local utils_dir="$DOTFILES_DIR/utils"

    if [ -f "$utils_dir/utils.sh" ]; then
        info "Installing basic utilities from utils.sh..."
        bash "$utils_dir/utils.sh"
        success "Basic utilities are installed"
    fi

    for app_dir in "$utils_dir"/*/; do
        [ -d "$app_dir" ] || continue

        local app_name
        app_name="$(basename "$app_dir")"
        local install_script="$app_dir/install.sh"

        if [ -f "$install_script" ]; then
            info "Installing application: $app_name..."
            (cd "$app_dir" && bash install.sh)
            success "$app_name has been successfully installed"
        else
            warn "Install.sh not found for $app_name, skipping"
        fi
    done
}

# Terminal
setup_terminal() {
    info "Configuring Alacritty and Ghostty..."

    local term_dir="$DOTFILES_DIR/terminal"

    # --- Alacritty ---
    if ! command -v alacritty &> /dev/null; then
        info "Installing Alacritty via DNF..."
        sudo dnf install -y alacritty
    else
        info "Alacritty is already installed"
    fi

    local alacritty_dir="$term_dir/alacritty"
    if [ -d "$alacritty_dir" ]; then
        if [ -f "$alacritty_dir/alacritty.toml" ]; then
            link_file "$alacritty_dir/alacritty.toml" "$HOME/.config/alacritty/alacritty.toml"
        fi

        if [ -d "$alacritty_dir/themes" ]; then
            link_file "$alacritty_dir/themes" "$HOME/.config/alacritty/themes"
        fi
    fi

    # --- Ghostty ---
    if ! command -v ghostty &> /dev/null; then
        info "Installing Ghostty via COPR...."
        sudo dnf copr enable -y scottames/ghostty || sudo dnf copr enable -y pgdev/ghostty
        sudo dnf install -y ghostty
    else
        info "Ghostty is already installed!"
    fi

    local ghostty_dir="$term_dir/ghostty"
    if [ -d "$ghostty_dir" ]; then
        if [ -f "$ghostty_dir/config" ]; then
            link_file "$ghostty_dir/config" "$HOME/.config/ghostty/config"
        fi

        if [ -d "$ghostty_dir/themes" ]; then
            link_file "$ghostty_dir/themes" "$HOME/.config/ghostty/themes"
        fi
    fi

    success "Terminals have been successfully configured."
}

# Main
main() {
    info "Launching the dot file installation from $DOTFILES_DIR"

    setup_utils
    setup_fonts
    setup_fedora_shortcuts
    setup_zsh
    setup_git
    setup_ide
    setup_terminal

    success "Completed!"
}

main "$@"
