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
function vi-yank-pbcopy() {
	zle vi-yank
	echo ${CUTBUFFER} | pbcopy
}

function vi-yank-eol-pbcopy() {
 	zle vi-yank-eol
	echo ${CUTBUFFER} | pbcopy
}

function vi-delete-pbcopy() {
  zle vi-delete
	echo ${CUTBUFFER} | pbcopy
}

function vi-delete-char-pbcopy() {
  zle vi-delete-char
	echo ${CUTBUFFER} | pbcopy
}

zle -N vi-yank-pbcopy
zle -N vi-yank-eol-pbcopy
zle -N vi-delete-pbcopy
zle -N vi-delete-char-pbcopy
bindkey -M vicmd 'y' vi-yank-pbcopy
bindkey -M vicmd 'Y' vi-yank-eol-pbcopy
bindkey -M vicmd 'd' vi-delete-pbcopy
bindkey -M vicmd 'x' vi-delete-char-pbcopy

bindkey -v
_zsh_cli_fg() { fg; }
zle -N _zsh_cli_fg
bindkey '^Z' _zsh_cli_fg
bindkey '^?' backward-delete-char

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
alias bop="python3 ~/github/python/worldBopper9001.py"
alias cat="bat"
alias ls="exa"
alias rp="rust-project"
alias template="cp -r $HOME/Documents/notes . && cd notes && $EDITOR main.tex"
alias cpb=". cpb_cd"
alias cpbooster=". cpb_cd"

# Speed up tab completion for git commands
__git_files () { 
    _wanted files expl 'local files' _files     
}

# Enable and load bashcompinit
autoload -Uz compinit bashcompinit
compinit
bashcompinit

# Argcomplete explicit registration for pubs
# eval "$(register-python-argcomplete pubs)"

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

