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
ZSH_HIGHLIGHT_STYLES[command]='fg=#7aa2f7,bold'       # Commands blue
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=#f7768e'      # Errors red
ZSH_HIGHLIGHT_STYLES[path]='fg=#9ece6a'               # Paths green
ZSH_HIGHLIGHT_STYLES[alias]='fg=#7dcfff'              # Aliases light-blue

alias ll='ls -lah --color=auto'
alias update='sudo dnf update -y'

# ls color + tab dirs
export LS_COLORS="di=01;32:ln=01;35:so=01;32:pi=01;33:ex=01;32:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=01;36:ow=01;36"
alias ls='ls --color=auto'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Golang
export GOROOT="/home/stepan41k/sdk/go1.26.0"
export PATH="$GOROOT/bin:$PATH"
alias go='/home/stepan41k/sdk/go1.26.0/bin/go'

# zsh config
alias zconf="micro ~/.zshrc"

# Ghostty config
alias ghostconf='micro ~/.config/ghostty/config'

# Docker aliases
alias dstart='sudo systemctl start docker.socket docker.service'
alias dstop='sudo systemctl stop docker.socket docker.service'
alias drestart='sudo systemctl restart docker.socket docker.service'
alias dstat='systemctl status docker.service docker.socket'

# git config
alias gitconf='micro ~/.gitconfig'
