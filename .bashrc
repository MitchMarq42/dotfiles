if (which pwsh)
then
    exec pwsh
else
    ~/.local/bin/org-tangle ~/.config/zsh/README.org &&
	chsh -s $(which zsh) &&
	clear &&
	exec zsh -l
fi
