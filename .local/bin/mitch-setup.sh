#!/bin/sh

# .git_credentials file
# https://MitchMarq42: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@github.com

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
# sudo dnf install dnf-plugins-core

# sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/x86_64/

# sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc

# sudo dnf install brave-browser


# # On macos do:
# # check out
# # https://github.com/d12frosted/homebrew-emacs-plus

chsh $(which zsh)
