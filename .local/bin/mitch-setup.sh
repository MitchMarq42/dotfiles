#!/bin/sh

# Get the dots function itself
curl https://raw.githubusercontent.com/MitchMarq42/dotfiles/main/.local/bin/dots > ~/.local/bin/dots

git clone https://github.com/mitchmarq42/dotfiles --bare ~/.local/git/dotfiles

# run
dots checkout -f

curl 'https://i.ytimg.com/vi/0NHIlU4l02E/maxresdefault.jpg' > .local/share/backgrounds/shockwave.jpg

gnomes=$(ls ~/.config/gnome-custom-configs/ |
	     grep gsets |
      sed 's/\.gsets$//g')

for prop in $gnomes
do
    dconf load /org/gnome/$prop/ < ~/.config/gnome-custom-configs/$prop.gsets
done

dots submodule init
dots submodule update

sudo dnf upgrade -y
sudo dnf search chsh
sudo dnf install util-linux
sudo dnf install zsh emacs qutebrowser gnome-tweak-tool gnome-extensions
sudo dnf install zsh emacs qutebrowser gnome-tweak-tool gnome-shell-extensions
sudo dnf install zsh emacs qutebrowser gnome-tweak-tool neovim
sudo dnf search gnome extensions
sudo dnf install gnome-extensions-app
sudo dnf install gnome-extensions-app util-linux-user
sudo dnf install gnome-extensions-app 
sudo dnf install util-linux-user

chsh $(which zsh)
