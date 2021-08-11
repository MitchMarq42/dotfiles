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

# Do git bare repo stuff
dots() {
    /usr/bin/git --git-dir=$HOME/git/dotfiles --work-tree=$HOME $@
    ## I had a great explanation for all these things, but
    ## git does not take multi-line arguments.
}

# Sudo is a bitch so bitch about it
sudo() {
    which doas >/dev/null && doas $@ ||
}
