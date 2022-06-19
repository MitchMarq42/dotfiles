if (which pwsh 2>/dev/null )
then
    echo ""
    # exec pwsh
else
    ~/.local/bin/org-tangle ~/.config/zsh/README.org &&
	# chsh -s $(which zsh) &&
	clear &&
	exec zsh -l
fi
