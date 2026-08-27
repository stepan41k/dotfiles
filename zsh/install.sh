#!/usr/bin/env bash

set -e

echo "=== Настройка Zsh для Fedora ==="

# 1. Установка Zsh через dnf, если не установлен
if ! command -v zsh &> /dev/null; then
    echo "Установка Zsh через DNF..."
    sudo dnf install -y zsh util-linux-user curl git
fi

# 2. Установка Oh My Zsh (в неинтерактивном режиме)
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Установка Oh My Zsh..."
    RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    echo "Oh My Zsh уже установлен."
fi

# Путь к кастомным плагинам
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

# Функция установки или обновления git-репозитория плагина
install_or_update() {
    local repo_url="$1"
    local dest_dir="$2"
    local plugin_name
    plugin_name="$(basename "$dest_dir")"

    if [ -d "$dest_dir" ]; then
        echo "Обновление плагина $plugin_name..."
        git -C "$dest_dir" pull --quiet
    else
        echo "Клонирование плагина $plugin_name..."
        git clone --depth=1 "$repo_url" "$dest_dir"
    fi
}

# 3. Установка плагинов
mkdir -p "$ZSH_CUSTOM/plugins"
install_or_update "https://github.com/zsh-users/zsh-autosuggestions" "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
install_or_update "https://github.com/zsh-users/zsh-syntax-highlighting.git" "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"

# 4. Смена дефолтной оболочки на zsh (если текущая не zsh)
CURRENT_SHELL="$(basename "$SHELL")"
if [ "$CURRENT_SHELL" != "zsh" ]; then
    ZSH_PATH="$(which zsh)"
    echo "Смена оболочки по умолчанию на $ZSH_PATH..."
    sudo chsh -s "$ZSH_PATH" "$USER" || chsh -s "$ZSH_PATH"
fi

echo "Настройка Zsh и плагинов завершена успешно!"