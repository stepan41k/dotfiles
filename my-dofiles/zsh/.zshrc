export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(
    git 
    zsh-autosuggestions 
    zsh-syntax-highlighting 
    sudo
)

source $ZSH/oh-my-zsh.sh

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#565f89"

typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[command]='fg=#7aa2f7,bold'      # Commands blue
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=#f7768e'      # Errors red
ZSH_HIGHLIGHT_STYLES[path]='fg=#9ece6a'               # Paths green
ZSH_HIGHLIGHT_STYLES[alias]='fg=#7dcfff'              # Aliases light-blue

alias ll='ls -lah --color=auto'
alias update='sudo dnf update -y'
alias conf='nano ~/.config/alacritty/alacritty.toml'