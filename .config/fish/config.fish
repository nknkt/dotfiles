# homebrew
set PATH /opt/homebrew/bin $PATH

# Golang
set -x GOPATH $HOME/dev
set -x PATH $PATH $GOPATH/bin

# ghq + peco
set -g GHQ_SELECTOR peco
function fish_user_key_bindings
    bind \cc 'peco_cd'
    bind \ck peco_kill
    bind \cw 'peco_select_history (commandline -b)'
    bind \cr peco_recentd
end

# starship
starship init fish | source

# fnm
eval (fnm env)

# Provides the ability to automatically switch Node.js versions when a directory is changed
fnm env --use-on-cd --shell fish | source

# docker
source /Users/kenta_kanno/.docker/init-fish.sh || true # Added by Docker Desktop