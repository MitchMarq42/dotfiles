#!/bin/sh

# # On Ubuntu do:
# sudo apt install git curl emacs zsh

# Get the dots function itself
[ -f ~/.local/bin/dots ] ||
    curl https://raw.githubusercontent.com/MitchMarq42/dotfiles/main/.local/bin/dots > ~/.local/bin/dots && chmod +x ~/.local/bin/dots

[ -d ~/.local/git/dotfiles ] ||
    git clone https://github.com/mitchmarq42/dotfiles --bare ~/.local/git/dotfiles

# run
~/.local/bin/dots checkout -f

gnomes=$(
    ls ~/.config/gnome-custom-configs/ |
	grep gsets |
	sed 's/\.gsets$//g'
      )

for prop in $gnomes
do
    dconf load /org/gnome/$prop/ < ~/.config/gnome-custom-configs/$prop.gsets
done

dots submodule init
dots submodule update

# # On fedora do:
# sudo dnf upgrade -y
# sudo dnf install util-linux zsh emacs qutebrowser gnome-tweak-tool neovim gnome-extensions-app util-linux-user

# # On macos do:
# # check out
# # https://github.com/d12frosted/homebrew-emacs-plus

chsh $(which zsh)
