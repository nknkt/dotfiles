set PATH /opt/homebrew/bin $PATH

# Golang
set -x GOPATH $HOME/dev
set -x PATH $PATH $GOPATH/bin

# ghq + peco
set -g GHQ_SELECTOR peco

function fish_user_key_bindings
	bind \cc 'peco_cd'
	bind \cx\ck peco_kill
	bind \cw 'peco_select_history (commandline -b)'
	bind \cx\cr peco_recentd
end

starship init fish | source