# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zmodload zsh/complist
compinit
_comp_options+=(globdots)
setopt MENU_COMPLETE

# use vim keys to navigate completions
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
export KEYTIMEOUT=1

# fix pasting
zstyle ':bracketed-paste-magic' active-widgets '.self-*'

# yank to the system clipboard
function zvm_vi_yank() {
	zvm_yank
	echo ${CUTBUFFER} | pbcopy
	zvm_exit_visual_mode
}

bindkey -v
_zsh_cli_fg() { fg; }
zle -N _zsh_cli_fg
bindkey '^Z' _zsh_cli_fg
bindkey -v '^?' backward-delete-char

# change terminal title to current working directory
precmd () { print -Pn "\e]0;%~\a" }

# aliases
alias vrc="$EDITOR ~/.config/nvim/fnl/config.fnl"
alias hrc="$EDITOR ~/.config/helix/config.toml"
alias zrc="$EDITOR ~/.config/zsh/.zshrc"
alias yrc="$EDITOR ~/.config/yabai/yabairc"
alias frc="$EDITOR ~/.config/firefox/userChrome.css"
alias barrc="$EDITOR ~/.config/sketchybar/sketchybarrc"
alias src="$EDITOR ~/.config/skhd/skhdrc"
alias arc="$EDITOR ~/.config/alacritty/alacritty.yml"
alias vim="nvim"
alias vimdiff="nvim -d"
alias nvsync="nvim +'au User PackerComplete qa' +PackerSync"
alias ranger=". ranger"
alias icat="kitty +kitten icat"
alias pubs="pubs --config $HOME/.config/pubs/pubsrc"
alias kbd="$EDITOR ~/.config/qmk_firmware/keyboards/hhkb/jp/keymaps/cobcobs/keymap.c"
alias bop="python3 ~/github/python/worldBopper9000.py"
alias librewolf="/Applications/LibreWolf.app/Contents/MacOS/librewolf"

# feh but for macos
function feh() {
    open -b "drabweb.macfeh" "$@"
}

# synctex stuff
export DBUS_SESSION_BUS_ADDRESS="unix:path=$DBUS_LAUNCHD_SESSION_BUS_SOCKET"

# Speed up tab completion for git commands
__git_files () { 
    _wanted files expl 'local files' _files     
}

# Enable and load bashcompinit
autoload -Uz compinit bashcompinit
compinit
bashcompinit
# Argcomplete explicit registration for pubs
eval "$(register-python-argcomplete pubs)"

# move zsh-history and zcompdump files
export HISTFILE="$HOME/.config/zsh/zsh-history"
compinit -d ~/.config/zsh/zcompdump-$ZSH_VERSION

# source plugins and change some settings
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# source /opt/homebrew/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=cyan'
ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT

# Homebrew
function brew() {
  command brew "$@" 

  if [[ $* =~ "upgrade" ]] || [[ $* =~ "update" ]] || [[ $* =~ "outdated" ]]; then
    sketchybar --trigger brew_update
  fi
}

if [[ $(uname -m) == 'arm64' ]]; then
    BREWPATH=/opt/homebrew/bin
else
    BREWPATH=/usr/local/bin
fi
export PATH=$BREWPATH:$PATH

# thefuck
eval $(thefuck --alias)

# pyenv
eval "$(pyenv init -)"

# Terminal Prompt
source /opt/homebrew/opt/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

