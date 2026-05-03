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


alias update='sudo dnf update -y' # dnf update

# ls color + tab dirs
export LS_COLORS="di=01;32:ln=01;35:so=01;32:pi=01;33:ex=01;32:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=01;36:ow=01;36"
alias ls='ls --color=auto' # ls colors
alias ll='ls -lah --color=auto' # ls with permissions
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Golang
export GOROOT="/home/stepan41k/sdk/go1.26.0"
export PATH="$GOROOT/bin:$PATH"
alias go='/home/stepan41k/sdk/go1.26.0/bin/go' # Go sdk


# Configs
alias gitconf='micro ~/.gitconfig' # Open Git configuration
alias ghostconf='micro ~/.config/ghostty/config' # Open Ghostty configuration
alias zconf="micro ~/.zshrc" # Open zsh configuration

# Docker aliases
alias dstart='sudo systemctl start docker.socket docker.service' # Docker daemon start
alias dstop='sudo systemctl stop docker.socket docker.service' # Docker daemon stop
alias drestart='sudo systemctl restart docker.socket docker.service' # Docker daemor restart
alias dstat='systemctl status docker.service docker.socket' # Docker daemon state

# My Aliases
function myalias() {
    echo "My Custom Aliases:"
    echo "--------------------------------------------------------------------------------------------"
    
    grep -h "^alias " ~/.zshrc ~/.oh-my-zsh/custom/*.zsh 2>/dev/null | \
    sed -E "s/^alias //; s/=['\"](.*)['\"]/|\1/; s/ # /|/" | \
    awk -F'|' '{
        printf "\033[1;32m%s\033[0m|\033[0;37m%s\033[0m|\033[0;90m%s\033[0m\n", $1, $2, $3
    }' | column -t -s '|'
    echo "\n"
}
