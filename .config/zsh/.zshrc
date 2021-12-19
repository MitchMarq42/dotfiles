# vim: set ft=sh :

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# start X or sway on tty7
[[ $(tty) = /dev/tty7 ]] && exec sway
[[ $(tty) = /dev/tty5 ]] && startx

# note the previous value of $TERM, for self-awareness in tmuxes.
[ -z "${TMUX}" ] && export OLDTERM="${TERM}"
# Start a new tmux session to put the current shell in, if not already in a tmux or alacritty. Remember old TERM.
[ -z "${TMUX}" ] && [[ "${TERM}" != alacritty ]] && [[ "${TERM}" != linux ]] && [[ "${TERM}" != xterm-256color ]] && OLDTERM="${TERM}" exec tmux

# Maybe install zplug, and definitely make it update stuff
[ -n {XDG_CONFIG_HOME:$HOME/.config}/zsh/zplug ] && (
    export ZPLUG_HOME=~/.config/zsh/zplug
    git clone https://github.com/zplug/zplug $ZPLUG_HOME 2>/dev/null
)
source ~/.config/zsh/zplug/init.zsh
zplug 'zplug/zplug', hook-build:'zplug --self-manage'
zplug "romkatv/powerlevel10k", as:theme, depth:1
zplug "zdharma-continuum/fast-syntax-highlighting", defer:2
# zplug 'zsh-users/zsh-history-substring-search', depth:1
zplug 'zsh-users/zsh-autosuggestions'
# Install plugins if there are plugins that have not been installed
zplug check --verbose || (
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
)

# Choose a fetch based on the width of the terminal and run it, since we are firmly in an interactive shell now.
(( $COLUMNS <= 84 )) && FETCH=pfetch || FETCH='neofetch'
$FETCH --ascii_colors 4 --colors 7 4 4 4 4 7

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Switch escape and caps if tty and no passwd required:
# doas -n loadkeys ~/.local/share/ttymaps.kmap 2>/dev/null

# Lines configured by zsh-newuser-install
HISTFILE=~/.local/share/zsh/histfile
HISTSIZE=1000
SAVEHIST=1000
setopt extendedglob nomatch
setopt HIST_IGNORE_ALL_DUPS
unsetopt autocd beep
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename "$ZDOTDIR/.zshrc"
autoload -Uz compinit
# Basic auto/tab complete
zstyle ':completion:*' menu select
zmodload zsh/complist
_comp_options+=(globdots)		# Include hidden files.
compinit
# End of lines added by compinstall

# Use vim keys in tab complete menu etc:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v "^?" backward-delete-char
autoload edit-command-line; zle -N edit-command-line
bindkey '^v' edit-command-line

autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '^[[A' up-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search
bindkey -M vicmd 'k' up-line-or-beginning-search
bindkey -M vicmd 'j' down-line-or-beginning-search

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

# source aliases and functions files
source ~/.config/zsh/aliases.zsh
source ~/.config/zsh/functions.zsh
source ~/.config/zsh/insulter.zsh

# Make gpg work
export GPT_TTY=$(tty)

#############################################################
######   Luke Smith's custom vi-mode cursor switcher   ######
#############################################################
function zle-keymap-select {
    if [[ ${KEYMAP} == vicmd ]] || [[ $1 = 'block' ]];
    then echo -ne '\e[1 q'
    elif [[ ${KEYMAP} == main ]] ||
    [[ ${KEYMAP} == viins ]] ||
        [[ ${KEYMAP} = '' ]] ||
        [[ $1 = 'beam' ]];
    then echo -ne '\e[5 q'
    fi
}
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-keymap-select
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.
#############################################################
###### End Luke Smith's custom vi-mode cursor switcher ######
#############################################################

# Finally load those zplugs
zplug load
