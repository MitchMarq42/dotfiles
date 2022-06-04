#!/bin/sh

# # On Ubuntu do:
# sudo apt install git curl emacs zsh

# Relevant directories
mkdir -p \
      ~/.local/bin \
      ~/.local/git \
      ~/.config/gnupg \
      ~/.local/share/zsh 

# Get the dots function itself
[ -f ~/.local/bin/dots ] ||
	curl https://git.mitchmarq42.xyz/mitch/dotfiles/raw/branch/main/.local/bin/dots > ~/.local/bin/dots && chmod +x ~/.local/bin/dots

[ -d ~/.local/git/dotfiles ] ||
    git clone https://git.mitchmarq42.xyz/mitch/dotfiles --bare ~/.local/git/dotfiles

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

# On fedora do: {
#     # Normal stuff
#     sudo dnf upgrade -y
#     sudo dnf install util-linux zsh emacs qutebrowser gnome-tweak-tool neovim gnome-extensions-app util-linux-user
#     sudo dnf install dnf-plugins-core
#     # rmpfusion
#     sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
#     # brave:
#     sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/x86_64/
#     sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
#     sudo dnf install brave-browser
#     # powershell:
#     sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
#     curl https://packages.microsoft.com/config/rhel/7/prod.repo | sudo tee /etc/yum.repos.d/microsoft.repo
#     sudo dnf check-update
#     sudo dnf install compat-openssl10
#     sudo dnf install -y powershell
# }

# On Arch do: {
#     # arch things
# }

# # On macos do:
# # check out
# # https://github.com/d12frosted/homebrew-emacs-plus

chsh $(which zsh)
