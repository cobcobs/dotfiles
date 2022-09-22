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

function zvm_yank() {
	zvm_yank
  echo ${CUTBUFFER} | pbcopy
}

# suspend or enter vim
_zsh_cli_fg() { fg; }
zle -N _zsh_cli_fg
bindkey '^Z' _zsh_cli_fg

# change terminal title to current working directory
precmd () { print -Pn "\e]0;%~\a" }

# aliases
alias vrc="$EDITOR ~/.config/nvim/fnl/modules/config/default/config.fnl"
alias zrc="yadm enter $EDITOR ~/.config/zsh/.zshrc"
alias yrc="yadm enter $EDITOR ~/.config/yabai/yabairc"
alias frc="yadm enter $EDITOR ~/.config/firefox/userChrome.css"
alias barrc="yadm enter $EDITOR ~/.config/sketchybar/sketchybarrc"
alias src="yadm enter $EDITOR ~/.config/skhd/skhdrc"
alias arc="yadm enter $EDITOR ~/.config/alacritty/alacritty.yml"
alias vimdiff="nvim -d"
# alias nvprofile="rm ~/.cache/nvim/startup.log ; env AK_PROFILER=1 nvim 2>~/.cache/nvim/startup.log >/dev/null && nvim ~/.cache/nvim/startup.log"
# alias nvsync="nvim +'au User PackerComplete qa' +PackerSync"
# alias ranger=". ranger"
alias icat="kitty +kitten icat"
alias pubs="pubs --config $HOME/.config/pubs/pubsrc"
alias kbd="$EDITOR ~/.config/qmk_firmware/keyboards/hhkb/jp/keymaps/cobcobs/keymap.c"
alias bop="python3 ~/github/python/worldBopper9000.py"
alias librewolf="/Applications/LibreWolf.app/Contents/MacOS/librewolf"

nyoom() {
  cd $HOME/.config/nvim && bin/nyoom $1 ; cd - &> /dev/null
}

vim() {
  if [ "$1" != "" ]
  then
    $EDITOR "$@"
  else
    $EDITOR .
  fi
}
alias nvim='vim'

# feh but for macos
function feh() {
    open -b "drabweb.macfeh" "$@"
}

# synctex stuff
export DBUS_SESSION_BUS_ADDRESS='unix:path='$DBUS_LAUNCHD_SESSION_BUS_SOCKET

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
source /opt/homebrew/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=cyan'
ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT

# Homebrew
eval $(/opt/homebrew/bin/brew shellenv)

# thefuck
eval $(thefuck --alias)

# pyenv
eval "$(pyenv init -)"

# Terminal Prompt
source /opt/homebrew/opt/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

