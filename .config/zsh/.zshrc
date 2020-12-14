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
function zle-keymap-select zle-line-init
{
    # change cursor shape in Alacritty
    case $KEYMAP in
        vicmd)      print -n -- "\E]50;CursorShape=0\C-G";;  # block cursor
        viins|main) print -n -- "\E]50;CursorShape=1\C-G";;  # line cursor
    esac

    zle reset-prompt
    zle -R
}

function zle-line-finish
{
    print -n -- "\E]50;CursorShape=0\C-G"  # block cursor
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

# aliases
eval $(thefuck --alias frick)

alias config='chezmoi'
alias bluetooth='bluetoothconnector'
alias vrc='vim ~/.config/nvim/init.vim'
alias zrc='vim ~/.config/zsh/.zshrc'
alias yrc='vim ~/.config/yabai/yabairc'
alias frc='vim ~/Library/Application\ Support/Firefox/Profiles/fo46dfhz.default-release/chrome/userChrome.css'
alias barrc='vim ~/.config/spacebar/spacebarrc'
alias src='vim ~/.config/skhd/skhdrc'
alias arc='vim ~/.config/alacritty/alacritty.yml'
alias vim='nvim'
alias vimdiff='nvim -d'
alias pyprojects='cd "/Users/jacobethandelarosa-frio/Documents/Stuff/Engineering/Programming/Python/projects/"'

# macfeh
function feh() {
    open -b "drabweb.macfeh" "$@"
}

# shfm
function shfm() {
    cd "$(command shfm "$@")"
}

# import colorscheme from 'wal' asynchronously
# &   # Run the process in the background.
# ( ) # Hide shell job control messages.
(cat ~/.cache/wal/sequences &)

# load pyenv
# eval "$(pyenv init - zsh --no-rehash)"

# conda
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/usr/local/Caskroom/miniconda/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/usr/local/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
        . "/usr/local/Caskroom/miniconda/base/etc/profile.d/conda.sh"
    else
        export PATH="/usr/local/Caskroom/miniconda/base/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# Setup fzf
# ---------
if [[ ! "$PATH" == */usr/local/opt/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/usr/local/opt/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/usr/local/opt/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/usr/local/opt/fzf/shell/key-bindings.zsh"

export HISTFILE="$HOME/.config/zsh/zsh-history"
compinit -d ~/.config/zsh/zcompdump-$ZSH_VERSION

source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

source /usr/local/opt/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
