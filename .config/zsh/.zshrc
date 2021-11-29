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
bindkey -v '^?' backward-delete-char
export KEYTIMEOUT=1

# edit line in vim
autoload edit-command-line; zle -N edit-command-line
bindkey '^v' edit-command-line

# cursor shape in vim modes
function zle-keymap-select zle-line-init zle-line-finish
{
  case $KEYMAP in
      vicmd)      print -n '\033[1 q';; # block cursor
      viins|main) print -n '\033[5 q';; # line cursor
  esac
}

zle -N zle-line-init
zle -N zle-line-finish
zle -N zle-keymap-select

# fix pasting
zstyle ':bracketed-paste-magic' active-widgets '.self-*'

# yank to the system clipboard
function vi-yank-xclip {
    zle vi-yank
   echo "$CUTBUFFER" | pbcopy -i
}

zle -N vi-yank-xclip
bindkey -M vicmd 'y' vi-yank-xclip

# suspend or enter vim
_zsh_cli_fg() { fg; }
zle -N _zsh_cli_fg
bindkey '^Z' _zsh_cli_fg

# change terminal title to current working directory
precmd () { print -Pn "\e]0;%~\a" }

# aliases
alias bluetooth='bluetoothconnector'
alias vrc='vim ~/.config/nvim/init.lua'
alias zrc='vim ~/.config/zsh/.zshrc'
alias yrc='vim ~/.config/yabai/yabairc'
alias frc='vim ~/.config/firefox/userChrome.css'
alias barrc='vim ~/.config/sketchybar/sketchybarrc'
alias src='vim ~/.config/skhd/skhdrc'
alias arc='vim ~/.config/alacritty/alacritty.yml'
alias vim='nvim'
alias vimdiff='nvim -d'
alias ranger='ranger --choosedir=$HOME/.cache/ranger/rangerdir; LASTDIR=`cat $HOME/.cache/ranger/rangerdir`; cd "$LASTDIR"' # cd into current directory after quitting ranger

# Speed up tab completion for git commands
# ----------------------------------------
__git_files () { 
    _wanted files expl 'local files' _files     
}

export HISTFILE="$HOME/.config/zsh/zsh-history"
compinit -d ~/.config/zsh/zcompdump-$ZSH_VERSION

source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Homebrew
# ________
eval $(/opt/homebrew/bin/brew shellenv)

# Functions
# _________
fpath+=${ZDOTDIR:-~}/.zsh_functions

# Terminal Prompt
# ---------------
source /opt/homebrew/opt/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

