set -x PATH $HOME/.anyenv/bin $PATH
eval (anyenv init - | source)
# eval (direnv hook fish)
set -x NDENV_ROOT $HOME/.anyenv/envs/nodenv
set -x PATH $HOME/.anyenv/envs/nodenv/bin $PATH
set -x PATH $NDENV_ROOT/shims $PATH


function fish_user_key_bindings
	bind \cc 'peco_cd'
	bind \cx\ck peco_kill
	bind \cr 'peco_select_history (commandline -b)'
	bind \cx\cr peco_recentd
end

starship init fish | source