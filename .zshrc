# Minimal zsh configuration
# Main shell is fish - this is for compatibility only

# Homebrew PATH
if [[ -d "/opt/homebrew/bin" ]]; then
    export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
fi

# FNM (Node.js version manager)
if command -v fnm > /dev/null 2>&1; then
    eval "$(fnm env --use-on-cd)"
fi

# Docker initialization
if [[ -f ~/.docker/init-zsh.sh ]]; then
    source ~/.docker/init-zsh.sh
fi

# Switch to fish if available and we're in interactive mode
if [[ -o interactive ]] && command -v fish > /dev/null 2>&1; then
    echo "💡 Consider using fish shell as default: chsh -s $(which fish)"
fi