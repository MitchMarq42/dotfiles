### This is a setup that I use. You might find it bloated, or ugly, or even sacreligious. Nevertheless, it's what I use, so get over it.

---

Good luck installing xmonad with my config! I suuure do hope that it compiles successfully and doesn't fail at importing anything...

Also note: ~/.config/neofetch/config.conf has a couple of neat things going on with it:

- Makes the "Packages" function asynchronous to work better on Fedora or other slow package managers (fight me)

- Prints out the current tmux pane if the current session is in one (otherwise says "N/A")

- When paired with my `.zshrc`, prints out the previous value of the TERM variable (before tmux sets it to `screen`)
