# Log directory: ~/local/log
export LOCAL="$HOME/local"
mkdir -p "$LOCAL"
export BIN="$LOCAL/bin"
mkdir -p "$BIN"
export LOG="$LOCAL/log"
mkdir -p "$LOG"


# Install Xcode Command Line Tools if not installed
xcode-select -p >/dev/null 2>&1 || sudo xcode-select --install


# Install Homebrew if not installed
command -v brew >/dev/null 2>&1 || \
    {echo "Installing brew ..." && /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"}


# Configure PATH
export PATH="/Applications/MATLAB_R2025b.app/bin:$PATH"
export PATH="$BIN:$PATH"
export PATH="$LOCAL/sshtools:$PATH"
export PATH="$LOCAL/textools:$PATH"
export PATH="$LOCAL/gittools:$PATH"


# Zsh Prompt Configuration
autoload -U colors && colors
PROMPT="%{$fg_bold[green]%}[%{$reset_color%}%D{%d-%a-%H:%M:%S} %{$fg_bold[cyan]%}%m%{$reset_color%} %~%{$fg_bold[green]%}]%{$reset_color%}
%# "


# Enable history search with up/down arrows, matching the current input
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
# Bind keys for history search
bindkey "^[[A" up-line-or-beginning-search    # Up arrow
bindkey "^[[B" down-line-or-beginning-search  # Down arrow


# Enhanced command logging.
zsh_command_logger() {
    local log_dir="$LOG"
    local today=$(date +%Y%m%d)
    local log_file="$log_dir/zsh-${today}.log"
    local timestamp=$(date +%Y%m%d.%H%M%S)
    local current_command="$1"
    local current_dir="$2"  # Pass directory as parameter
    # Only log if command is not empty and not just spaces
    if [[ -n "${current_command// }" ]]; then
        # Create log entry
        echo "[${timestamp}:${current_dir}] ${current_command}" >> "$log_file" 2>/dev/null || true
    fi
}
# Initialize variables
typeset -g CURRENT_COMMAND=""
typeset -g CURRENT_DIR=""
# Capture BOTH command and directory BEFORE execution
capture_command() {
    CURRENT_COMMAND="$1"
    CURRENT_DIR="$PWD"  # Capture directory at the moment command is entered
}
# Log using the directory captured BEFORE execution
log_command() {
    if [[ -n "$CURRENT_COMMAND" && "$CURRENT_COMMAND" =~ [^[:space:]] ]]; then
        zsh_command_logger "$CURRENT_COMMAND" "$CURRENT_DIR"
    fi
    CURRENT_COMMAND=""
    CURRENT_DIR=""
}
# Add hooks
autoload -Uz add-zsh-hook
add-zsh-hook preexec capture_command
add-zsh-hook precmd log_command


# Clear both screen and scrollback buffer
clear-scrollback-and-screen() {
    printf '\033[2J\033[3J\033[1;1H'
    zle reset-prompt
}
zle -N clear-scrollback-and-screen
bindkey '^L' clear-scrollback-and-screen  # Ctrl+L


# Use GNU ls with color support
command -v gls >/dev/null 2>&1 || \
    {echo "Installing coreutils ..." && brew install coreutils}
alias ls='gls --color=auto'
alias ll='gls -l --color=auto'
alias la='gls -A --color=auto'
alias l='gls -lA --color=auto'
# LS_COLORS supports bold (1;), underline (4;), etc.
export LS_COLORS='di=1;37:fi=0:ln=0;36:so=0;35:pi=0;33:ex=1;32:bd=1;34:cd=1;34:su=0:sg=0:tw=0:ow=0:'


# Load NVM (Node Version Manager)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
