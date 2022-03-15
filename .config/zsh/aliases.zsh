# Don't edit this file. Edit the README.org instead, and tangle it.

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
alias ping="ping -c 4"
alias ip="ip -c"

# emacs() {
#     # if [[ $# -eq 0 ]]; then
#     #     /usr/bin/emacs # "emacs" is function, will cause recursion
#     #     return
#     # fi
#     args=($*)
#     # for ((i=0; i <= ${#args}; i++)); do
#     #     local a=${args[i]}
#     #     # NOTE: -c for creating new frame
#     #     if [[ ${a:0:1} == '-' && ${a} != '-c' && ${a} != '--' ]]; then
#     #         /usr/bin/emacs ${args[*]}
#     #         return
#     #     fi
#     # done
#     emacsclient -nc -a /usr/bin/emacs $args
# }

# alias nvim="emacs -nw"
# alias neovide="emacs"
# alias vi="emacs -Q"
#alias mpv="mpv --really-quiet"
# export ALTERNATE_EDITOR=''
emacs=$(which emacs)
alias emacs="emacsclient -a $emacs -nc"
# $TERM == alacritty && alias nvim="neovide"

export WM=$(neofetch wm | awk '{print $2}')
[[ ${WM} == sway ]] &&
    #alias emacs='swallow emacs' &&
    #alias neovide='swallow neovide' &&
    #alias mpv='swallow mpv' &&
    alias brave='swallow brave'
