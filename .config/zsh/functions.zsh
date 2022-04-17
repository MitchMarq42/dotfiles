tmux-clean() {
    sessions=$(
        tmux ls |
            grep -v attached |
            sed 's/\:\s.*$//'
            )
    for session in $sessions
    do
        tmux kill-session -t $session
    done
}

[ -n "${TMUX}" ] && (
    clear=$(which clear)
    clear() {
        $clear &&
            tmux clear-history &&
            $clear
    }
)

# vim: set ft=sh :
