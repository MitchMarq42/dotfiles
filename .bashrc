if (which pwsh 2>/dev/null )
then
    exec pwsh
else
    ~/.local/bin/org-tangle ~/.config/zsh/README.org &&
	# chsh -s $(which zsh) &&
	clear &&
	exec zsh -l
fi
