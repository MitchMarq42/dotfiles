# Don't edit this file. Edit the README.org instead, and tangle it.

#which doas >/dev/null && alias sudo='doas'
which exa >/dev/null && alias ls='exa'
which exa >/dev/null && alias tree='exa -T'
which rg >/dev/null && alias grep='rg -uuu'
#which dotacat >/dev/null && alias lolcat='dotacat'

# [ -f /usr/bin/paru ] && alias pacman="paru" || alias pacman="sudo pacman"
alias cd..="cd .."
alias spider="spider -s 2 -c"
alias mounr="doas mount"
alias umounr="doas umount -r"
# alias dc="curl -s -L https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh | bash"
alias ping="ping -c 4"
alias ip="ip -c"
