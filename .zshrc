export PATH="/Applications/MATLAB_R2025b.app/bin:$PATH"
export PATH="$HOME/local/bin:$PATH"
export PATH="$HOME/local/sshtools:$PATH"
export PATH="$HOME/local/textools:$PATH"
export PATH="$HOME/local/gittools:$PATH"

# Enable history search with up/down arrows, matching the current input
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
# Bind keys for history search
bindkey "^[[A" up-line-or-beginning-search    # Up arrow
bindkey "^[[B" down-line-or-beginning-search  # Down arrow

# Clear both screen and scrollback buffer
clear-scrollback-and-screen() {
    printf '\033[2J\033[3J\033[1;1H'
    zle reset-prompt
}
zle -N clear-scrollback-and-screen
bindkey '^L' clear-scrollback-and-screen  # Ctrl+L

# Load NVM (Node Version Manager)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
