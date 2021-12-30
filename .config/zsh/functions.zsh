# Tmux clean function to kill detached sessions
tmux-clean() {
    sessions=$(tmux ls |
        grep -v attached |
        sed 's/\:\s.*$//'
        )
    for session in $sessions
    do
        tmux kill-session -t $session
    done
}
[ -n "${TMUX}" ] && (
    # Clear tmux history as well as terminal screen with "clear"
    clear() {
        /usr/bin/clear &&
        tmux clear-history &&
        /usr/bin/clear
    }
)
# Advanced pacman -Ql without nonsense.
pacQl() {
    /usr/bin/pacman -Ql $@ |
    grep -v '/$' |
    awk '{print $2}'
}
lf () {
    ~/.local/bin/lfrun $@
}

# Do git bare repo stuff (moved to separate file)
# dots() {
#     $HOME/.local/bin/dots $@
# }

# Sudo is a bitch so bitch about it
#sudo() {
#    which doas >/dev/null && doas $@ ||
#}

# vim: set ft=sh :
