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

# fnm
set -gx PATH "/Users/kenta_kanno/Library/Caches/fnm_multishells/80456_1671090326072/bin" $PATH;
set -gx FNM_VERSION_FILE_STRATEGY "local";
set -gx FNM_LOGLEVEL "info";
set -gx FNM_NODE_DIST_MIRROR "https://nodejs.org/dist";
set -gx FNM_ARCH "arm64";
set -gx FNM_DIR "/Users/kenta_kanno/Library/Application Support/fnm";
set -gx FNM_MULTISHELL_PATH "/Users/kenta_kanno/Library/Caches/fnm_multishells/80456_1671090326072";
source /Users/kenta_kanno/.docker/init-fish.sh || true # Added by Docker Desktop
