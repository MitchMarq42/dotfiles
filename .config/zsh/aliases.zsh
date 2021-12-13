# aliases that make things easier for me by invoking rust programs you don't have
#which doas >/dev/null && alias sudo='doas'
which exa >/dev/null && alias ls='exa'
which exa >/dev/null && alias tree='exa -T'
which rg >/dev/null && alias grep='rg -uuu'
#which dotacat >/dev/null && alias lolcat='dotacat'
[ -f /usr/bin/paru ] && alias pacman="paru" || alias pacman="sudo pacman"
alias cd..="cd .."
alias spider="spider -s 2 -c"
alias mounr="doas mount"
alias umounr="doas umount -r"
alias dc="curl -s -L https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh | bash"
#alias mpv="mpv --really-quiet"
# $TERM == alacritty  && alias nvim="neovide"
export WM=$(neofetch wm | awk '{print $2}')
[[ ${WM} == sway ]] &&
    #alias emacs='swallow emacs' &&
    #alias neovide='swallow neovide' &&
    alias mpv='swallow mpv' &&
    alias brave='swallow brave'
