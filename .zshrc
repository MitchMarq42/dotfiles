# start X on tty7
[[ $(tty) = /dev/tty7 ]] && exec startx ~/.config/x11/xinitrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# note the previous value of $TERM, for self-awareness in tmuxes.
[ -z "${TMUX}" ] && export OLDTERM="${TERM}"
# Start a new tmux session to put the current shell in, if not already in a tmux or alacritty. Remember old TERM.
[ -z "${TMUX}" ] && [[ "${TERM}" != alacritty ]] && [[ "${TERM}" != linux ]] && [[ "${TERM}" != xterm-kitty ]] && OLDTERM="${TERM}" exec tmux

# Maybe install zplug, and definitely make it update stuff
[ -n {XDG_CONFIG_HOME:$HOME/.config}/zsh/zplug ] && (
    export ZPLUG_HOME=~/.config/zsh/zplug
    git clone https://github.com/zplug/zplug $ZPLUG_HOME 2>/dev/null
)
source ~/.config/zsh/zplug/init.zsh
zplug 'zplug/zplug', hook-build:'zplug --self-manage'
zplug "romkatv/powerlevel10k", as:theme, depth:1
zplug "zdharma/fast-syntax-highlighting", defer:2
# Install plugins if there are plugins that have not been installed
zplug check --verbose || (
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
)
# Do a bunch of things for tmux usage if we're in a tmux but not if we're not
[ -n "${TMUX}" ] && (
	#remove stupid status line in tmux, and do many other things. This
	#saves us the effort of creating a ~/.tmux.conf file, which pollutes $HOME.
	tmux set -g status off; tmux set -g mouse on
	tmux bind -Tcopy-mode WheelUpPane send -N1 -X scroll-up
	tmux bind -Tcopy-mode WheelDownPane send -N1 -X scroll-down
	tmux set-option -g renumber-windows on
	# Clear tmux history as well as terminal screen with "clear"
	#
	clear() {
		/usr/bin/clear &&
		tmux clear-history &&
		/usr/bin/clear
	}
)

# Choose a fetch based on the width of the terminal and run it, since we are firmly in an interactive shell now.
(( $COLUMNS <= 84 )) && FETCH=pfetch || FETCH=neofetch
$FETCH

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Switch escape and caps if tty and no passwd required:
doas -n loadkeys ~/.local/share/ttymaps.kmap 2>/dev/null

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt extendedglob nomatch
setopt HIST_IGNORE_ALL_DUPS
unsetopt autocd beep
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '~/.zshrc'
autoload -Uz compinit
# Basic auto/tab complete
zstyle ':completion:*' menu select
zmodload zsh/complist
_comp_options+=(globdots)		# Include hidden files.
compinit
# End of lines added by compinstall

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v "^?" backward-delete-char
autoload edit-command-line; zle -N edit-command-line
bindkey '^v' edit-command-line

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

#random exports for various quality-of-life things
export LANG="en_US.UTF-8"                                   # these two lines are
export LC_COLLATE="C"                                       # for silencing perl scripts
export MANPAGER="nvim -c 'set ft=man' -"                    # Nvim does manpages...
export BAT_THEME="base16"                                   # Don't really use bat
export EDITOR="nvim"
export LESSHISTFILE="-"                                     # stop ~/.lesshst from happening
export GHCUP_USE_XDG_DIRS="anything"                        # clean up HOME

# aliases that make things easier for me by invoking rust programs you don't have
alias ls='exa'
alias tree='exa -T'
alias grep='rg'
alias lolcat='dotacat'
alias pacman="paru"
alias spider="spider -s 2 -c"
alias mounr="doas mount"
alias umounr="doas umount -r"
alias rickroll="curl -s -L https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh | bash"
alias 'pacman -Ql'='pacQl'

# Have neomutt sync to gmail by becoming a mockery of itself
neomutt() {
	/usr/bin/neomutt $@ &&
	mbsync -a
}
# Tmux clean function to kill detached sessions
tmux-clean() {
	for session in $(
		tmux ls |
		grep -v attached |
		awk '{print $1}' |
		sed 's/://'
		)
	do
		tmux kill-session -t $session
	done
}
# Advanced pacman -Ql without nonsense.
pacQl() {
	/usr/bin/pacman -Ql $@ |
	grep -v '/$' |
	awk '{print $2}'
}
lf () {
	~/.local/bin/lfrun $@
}

# Do git bare repo stuff
dots() {
    /usr/bin/git --git-dir=$HOME/git/dotfiles --work-tree=$HOME $@ -a
    ## I had a great explanation for all these things, but
    ## git does not take multi-line arguments.
}

# add personal bin folder and emacs functions to path, for custom scripts
export PATH=~/.local/bin:$PATH:~/.emacs.d/bin

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

# Fix duplicate entries in PATH variable caused by sourcing this file multiple times
source ~/.local/bin/fixpath

# Finally load those zplugs
zplug load

#export PS1='\[\033[34m\]/home/mitch\n\[\033[32m\]> ' ##Doesn't work but would be nice if it did
