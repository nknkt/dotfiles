# =================================
# Fish Shell Configuration
# =================================

# Homebrew PATH設定
if test -d /opt/homebrew/bin
    set -gx PATH /opt/homebrew/bin $PATH
end

# 環境変数
set -gx EDITOR code
set -gx BROWSER "Google Chrome"
set -gx LANG ja_JP.UTF-8
set -gx LC_ALL ja_JP.UTF-8

# Go言語設定
set -gx GOPATH $HOME/dev
set -gx PATH $PATH $GOPATH/bin

# FNM (Node.js Version Manager)
if command -v fnm > /dev/null
    fnm env --use-on-cd | source
end

# Starship Prompt
if command -v starship > /dev/null
    starship init fish | source
end

# fzf設定（キーバインド設定より前に読み込む）
if test -f /opt/homebrew/opt/fzf/shell/key-bindings.fish
    source /opt/homebrew/opt/fzf/shell/key-bindings.fish
end

# キーバインド設定
function fish_user_key_bindings
    # fzfのキーバインドを先に設定
    if test -f /opt/homebrew/opt/fzf/shell/key-bindings.fish
        fzf_key_bindings
    end

    # ghq + peco でリポジトリ移動
    bind \cg '__ghq_repository_search'

    # peco 関連のキーバインド
    bind \cc 'peco_cd'
    bind \ck peco_kill
    bind \cw 'peco_select_history (commandline -b)'
    bind \cp peco_recentd
end

# エイリアス設定
if command -v exa > /dev/null
    alias ls='exa'
    alias la='exa -la'
    alias ll='exa -l'
    alias tree='exa --tree'
end

if command -v bat > /dev/null
    alias cat='bat'
end

if command -v rg > /dev/null
    alias grep='rg'
end

# Git エイリアス
alias g='git'
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline'
alias gd='git diff'

# 便利なエイリアス
alias c='code'
alias ..='cd ..'
alias ...='cd ../..'
alias reload='source ~/.config/fish/config.fish'

# peco + ghq 設定
set -g GHQ_SELECTOR peco

# Docker設定（存在する場合）
if test -f ~/.docker/init-fish.sh
    source ~/.docker/init-fish.sh
end

# ローカル設定（存在する場合）
if test -f ~/.config/fish/local.fish
    source ~/.config/fish/local.fish
end

# 魚の挨拶を無効化
set fish_greeting