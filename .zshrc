# ~/.zshrc - Enhanced Configuration (OMZ-free)

# ==============================================================================
# Zsh Core Settings (Apply to ALL shells)
# ==============================================================================

# History configuration
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY            # Share history between sessions
setopt HIST_EXPIRE_DUPS_FIRST   # Remove duplicates first when HISTSIZE reached
setopt HIST_IGNORE_DUPS         # Don't save duplicates
setopt HIST_REDUCE_BLANKS       # Remove superfluous blanks
setopt HIST_VERIFY              # Expand history before executing

# Security settings
umask 022                       # Set default permissions (022 → user: rwx, group: r-x, others: r-x)
setopt NO_CLOBBER               # Safer file redirection (don't overwrite with > use >! for override)

# Directory stack - replacement for autojump basics
setopt AUTO_PUSHD               # Push directory to stack when cd'ing
setopt PUSHD_IGNORE_DUPS        # Don't push duplicates
setopt PUSHD_SILENT             # Don't print directory stack after pushd/popd
DIRSTACKSIZE=10                 # Limit directory stack size

# ==============================================================================
# Environment Variables & Essential PATH Setup
# ==============================================================================

# Set default locale
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Editor settings
export EDITOR='vim'             # Set default editor
export VISUAL="$EDITOR"         # Consistent visual editor

# Google Cloud Auth Plugin Setting
export USE_GKE_GCLOUD_AUTH_PLUGIN=True

# Android SDK Setup
export ANDROID_HOME="$HOME/Library/Android/sdk"

# PATH Configuration using Zsh array handling
typeset -U path
path=(
    # Homebrew paths first for precedence
    /opt/homebrew/bin
    /opt/homebrew/sbin
    
    # User's personal bin directory
    "$HOME/bin"
    "$HOME/.local/bin"
    
    # Tool-specific paths
    "/opt/homebrew/opt/openssl@3/bin"
    "/opt/homebrew/opt/mysql-client/bin"
    "/opt/homebrew/opt/jpeg/bin"
    "/opt/homebrew/opt/postgis/bin"
    "/opt/homebrew/opt/node@22/bin"
    
    # Android SDK paths
    "$ANDROID_HOME/platform-tools"
    "$ANDROID_HOME/emulator"
    "$ANDROID_HOME/tools"
    "$ANDROID_HOME/tools/bin"
    
    # JetBrains & development tools
    "$HOME/.codeium/windsurf/bin"
    "$HOME/Library/Application Support/JetBrains/Toolbox/scripts"
    
    # Standard system paths (included for completeness)
    /usr/local/bin
    /usr/local/sbin
    /usr/bin
    /bin
    /usr/sbin
    /sbin
    
    # Keep existing PATH entries
    $path
)

# ==============================================================================
# Tool Initializations (Core functionality)
# ==============================================================================

# ASDF Version Manager
if [[ -f "$HOME/.asdf/asdf.sh" ]]; then
    . "$HOME/.asdf/asdf.sh"
fi

# Google Cloud SDK
GCLOUD_SDK_PATH="/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk"
if [[ -f "$GCLOUD_SDK_PATH/path.zsh.inc" ]]; then
    source "$GCLOUD_SDK_PATH/path.zsh.inc"
fi
if [[ -f "$GCLOUD_SDK_PATH/completion.zsh.inc" ]]; then
    source "$GCLOUD_SDK_PATH/completion.zsh.inc"
fi

# ==============================================================================
# Zsh Completions (Replacement for Oh-My-Zsh completions)
# ==============================================================================

# Initialize the completion system
autoload -Uz compinit
compinit -i

# Cache completions for faster startup
if [[ -n ~/.zcompdump(#qN.mh+24) ]]; then
    compinit -i
else
    compinit -C -i
fi

# Enhanced completion options
zstyle ':completion:*' menu select                    # Menu-driven completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}" # Colored completion menu
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # Case-insensitive
zstyle ':completion:*' verbose yes                    # Verbose completion info
zstyle ':completion:*:*:*:*:descriptions' format '%F{green}-- %d --%f'
zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}!- %d (errors: %e) -!%f'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'

# ==============================================================================
# Interactive-Only Configuration (Aliases, Prompts, Interactive Tools)
# ==============================================================================
if [[ $- == *i* ]]; then

    # --- Color setup ---
    autoload -U colors && colors
    
    # GNU/BSD ls color option differences
    if ls --color=auto &>/dev/null; then
        alias ls='ls --color=auto'    # GNU
    else
        export CLICOLOR=1             # BSD
        export LSCOLORS="ExGxBxDxCxEgEdxbxgxcxd"
    fi
    
    # --- Key bindings ---
    bindkey -e                         # Emacs key bindings
    bindkey '^[[A' history-search-backward  # Up arrow
    bindkey '^[[B' history-search-forward   # Down arrow
    bindkey '^[[H' beginning-of-line        # Home key
    bindkey '^[[F' end-of-line              # End key
    bindkey '^[[3~' delete-char             # Delete key
    
    # --- Personal Aliases ---
    # Configuration
    alias zshcfg="code ~/.zshrc"
    alias zshsrc="source ~/.zshrc"
    alias starshipconfig='${EDITOR:-vim} ~/.config/starship.toml'
    
    # Docker-related
    alias d='docker'
    alias dc="docker-compose"
    alias dce="docker-compose exec"
    alias dr="dc run --rm rails bundle exec rails"  # Added --rm flag
    alias dcw="docker-compose exec web bash"
    alias dps='docker ps'
    alias dpsa='docker ps -a'
    alias di='docker images'
    
    # Navigation
    alias ..="cd .."
    alias ...="cd ../.."
    alias ....="cd ../../.."
    alias -- -="cd -"                    # Go to previous directory with -
    
    # Common commands with useful defaults
    alias grep="grep --color=auto"
    alias mkdir="mkdir -p"
    alias cp="cp -i"                     # Confirm before overwriting
    alias mv="mv -i"                     # Confirm before overwriting
    alias ll="ls -la"                    # Long list format
    alias la="ls -A"                     # Show hidden files
    alias l='ls -CF'
    
    # Git shortcuts (minimal replacement for git plugin)
    alias g="git"
    alias gst="git status"
    alias ga="git add"
    alias gc="git commit"
    alias gp="git push"
    alias gl="git pull"
    alias gco="git checkout"
    alias gd="git diff"
    alias gb='git branch'
    alias glog='git log --oneline --graph'
    
    # Development aliases
    alias dev='cd ~/Development'
    alias reload='source ~/.zshrc'
    alias zshconfig='${EDITOR:-vim} ~/.zshrc'
    
    # Starship Profile Switching
    starship-profile() {
        local profile_dir="$HOME/Downloads/Learning/terminal-setup/.config/starship-profiles"
        local config_dir="$HOME/.config"
        
        case $1 in
            minimal)
                export STARSHIP_CONFIG="$profile_dir/minimal.toml"
                echo "✓ Switched to Minimal profile"
                ;;
            performance)
                export STARSHIP_CONFIG="$profile_dir/performance.toml"
                echo "⚡ Switched to Performance profile"
                ;;
            powerline)
                export STARSHIP_CONFIG="$profile_dir/powerline.toml"
                echo "🔲 Switched to Powerline profile"
                ;;
            nerd|icons)
                export STARSHIP_CONFIG="$profile_dir/nerd-icons.toml"
                echo "🎨 Switched to Nerd Icons profile"
                ;;
            dracula)
                export STARSHIP_CONFIG="$profile_dir/dracula-powerline.toml"
                echo "🧛 Switched to Dracula Powerline profile"
                ;;
            default|"")
                unset STARSHIP_CONFIG
                echo "↩️  Switched to Default profile"
                ;;
            list)
                echo "Available Starship profiles:"
                echo "  minimal     - Clean and fast"
                echo "  performance - Optimized for speed"
                echo "  powerline   - Classic powerline style"
                echo "  nerd/icons  - Rich with icons"
                echo "  dracula     - Dracula theme powerline"
                echo "  default     - Your standard config"
                return 0
                ;;
            *)
                echo "Unknown profile: $1"
                echo "Use 'starship-profile list' to see available profiles"
                return 1
                ;;
        esac
        
        # Reload shell to apply changes
        exec zsh
    }
    
    # Quick aliases for profile switching
    alias sp='starship-profile'
    alias sp-min='starship-profile minimal'
    alias sp-perf='starship-profile performance'
    alias sp-power='starship-profile powerline'
    alias sp-nerd='starship-profile nerd'
    alias sp-dracula='starship-profile dracula'
    alias sp-default='starship-profile default'
    
    # Enhanced ls with colors
    if command -v eza &> /dev/null; then
        alias ls='eza'
        alias ll='eza -la'
        alias la='eza -a'
        alias lt='eza --tree'
    fi
    
    # Better cat with syntax highlighting
    if command -v bat &> /dev/null; then
        alias cat='bat'
        export BAT_THEME="Night-Owl"
    fi
    
    # --- Utility Functions ---
    # Extract various archive types
    extract() {
        if [ -f $1 ] ; then
            case $1 in
                *.tar.bz2)   tar xjf $1     ;;
                *.tar.gz)    tar xzf $1     ;;
                *.bz2)       bunzip2 $1     ;;
                *.rar)       unrar e $1     ;;
                *.gz)        gunzip $1      ;;
                *.tar)       tar xf $1      ;;
                *.tbz2)      tar xjf $1     ;;
                *.tgz)       tar xzf $1     ;;
                *.zip)       unzip $1       ;;
                *.Z)         uncompress $1  ;;
                *.7z)        7z x $1        ;;
                *)           echo "'$1' cannot be extracted via extract()" ;;
            esac
        else
            echo "'$1' is not a valid file"
        fi
    }
    
    # Create directory and cd into it
    mkcd() {
        mkdir -p "$1" && cd "$1"
    }
    
    # --- Third-party interactive tools ---
    # Fuzzy Finder (fzf)
    if command -v fzf &> /dev/null; then
        # Set up fzf key bindings and fuzzy completion
        eval "$(fzf --zsh)"
        
        # Use fd for fzf if available
        if command -v fd &> /dev/null; then
            export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
            export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
        fi
        
        # Better preview
        export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
    fi
    
    # thefuck command correction
    if command -v thefuck &> /dev/null; then
        eval $(thefuck --alias)
    fi
    
    # Autojump directory navigation
    if [[ -f "/opt/homebrew/etc/profile.d/autojump.sh" ]]; then
        . "/opt/homebrew/etc/profile.d/autojump.sh"
    elif [[ -f "/usr/local/etc/profile.d/autojump.sh" ]]; then
        . "/usr/local/etc/profile.d/autojump.sh"
    fi
    
    # Ruby Version Manager (rbenv)
    if command -v rbenv &> /dev/null; then
        eval "$(rbenv init - zsh)"
    fi
    
    # Node Version Manager (if using nvm)
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
    
    # Python (pyenv)
    if command -v pyenv &> /dev/null; then
        export PYENV_ROOT="$HOME/.pyenv"
        export PATH="$PYENV_ROOT/bin:$PATH"
        eval "$(pyenv init -)"
    fi
    
    # Syntax Highlighting (must be sourced at the end)
    # Install with: brew install zsh-syntax-highlighting
    if [[ -f "/opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
        source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    elif [[ -f "/usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
        source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    fi
    
    # History substring search (must be after syntax highlighting)
    # Install with: brew install zsh-history-substring-search
    if [[ -f "/opt/homebrew/share/zsh-history-substring-search/zsh-history-substring-search.zsh" ]]; then
        source /opt/homebrew/share/zsh-history-substring-search/zsh-history-substring-search.zsh
        bindkey '^[[A' history-substring-search-up
        bindkey '^[[B' history-substring-search-down
    elif [[ -f "/usr/local/share/zsh-history-substring-search/zsh-history-substring-search.zsh" ]]; then
        source /usr/local/share/zsh-history-substring-search/zsh-history-substring-search.zsh
        bindkey '^[[A' history-substring-search-up
        bindkey '^[[B' history-substring-search-down
    fi
    
    # Starship prompt - A blazing-fast, cross-shell prompt
    # Replaces the simple default prompt with a more powerful one
    if command -v starship &> /dev/null; then
        eval "$(starship init zsh)"
    else
        # Fallback to simple prompt if Starship is not available
        PROMPT='%n@%m:%~$ '
    fi
    
    # --- Amazon Q Hooks ---
    # Uncomment these if you need Amazon Q features in interactive terminal
    # Q_PRE_HOOK="${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh"
    # [[ -f "$Q_PRE_HOOK" ]] && builtin source "$Q_PRE_HOOK"
    # Q_POST_HOOK="${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh"
    # [[ -f "$Q_POST_HOOK" ]] && builtin source "$Q_POST_HOOK"

fi # End of interactive-only block

# ==============================================================================
# Local Configuration Override
# ==============================================================================
# Source local config file if it exists (for machine-specific settings)
# This is where you should put sensitive information like API keys
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

# ==============================================================================
# End of ~/.zshrc
# ==============================================================================