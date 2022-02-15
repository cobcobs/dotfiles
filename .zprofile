# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$('/usr/local/Caskroom/miniconda/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "/usr/local/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
#         . "/usr/local/Caskroom/miniconda/base/etc/profile.d/conda.sh"
#     else
#         export PATH="/usr/local/Caskroom/miniconda/base/bin:$PATH"
#     fi
# fi
# unset __conda_setup
# <<< conda initialize <<<

export ZDOTDIR=$HOME/.config/zsh
export GOPATH=$HOME/Library/go
export PYTHONSTARTUP=$HOME/.config/python/.pythonrc
export PYLINTHOME=$HOME/.config/python/pylint
export GNUPGHOME=$HOME/.config/gnupg
export PYENV_ROOT=$HOME/.config/pyenv
export IPYTHONDIR=$HOME/.config/iPython
export NPM_CONFIG_USERCONFIG=$HOME/.config/npm/.npmrc
export SPICETIFY_CONFIG=$HOME/Library/spicetify_data
export LESSHISTFILE=$HOME/.cache/less/lesshst
export SQLITE_HISTORY=$HOME/.cache/sqlite_history
export GNUPGHOME=$HOME/.local/share/gnupg
export VISUAL=lvim
export EDITOR=$VISUAL
export RANGER_LOAD_DEFAULT_RC=FALSE
export PATH="$HOME/.config/scripts:$HOME/.local/bin:$PATH"

source $HOME/.cargo/env
