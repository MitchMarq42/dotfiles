#### This is a setup that I use. You might find it bloated, or ugly, or even sacreligious. Nevertheless, it's what I use, so get over it.

---

Good luck installing xmonad with my config! I suuure do hope that it compiles successfully and doesn't fail at importing anything...

Also note: ~/.config/neofetch/config.conf has a couple of neat things going on with it:

- Makes the "Packages" function asynchronous to work better on Fedora or other slow package managers (fight me)

- Prints out the current tmux pane if the current session is in one (otherwise says "N/A")

- When paired with my `.zshrc`, prints out the previous value of the TERM variable (before tmux sets it to `screen`)

- Prints out your currently-booted init system. The Artix inits work as expected, systemd insults you, and anything else spews nonsense.

---

##### Notes on mrandr:

Use it as you would `xrandr -o`. E.G., `mrandr right` rotates the screen clockwise by 90 degrees. Et cetera.

There is a comment at the beginning of the executable linking to an extremely helpful Ubuntu Wiki page on the subject, so check that out too.

To make it run automatically on gyroscope/accelerometer events, learn C or something.

Instead, bind it to a hotkey. I currently have it bound to ctrl+alt+arrowkey via sxhkd (https://wiki.archlinux.org/title/sxhkd):

    control + alt + Up
        /home/mitch/.local/bin/mrandr inverted
    control + alt + Down
        /home/mitch/.local/bin/mrandr normal
    control + alt + Left
        /home/mitch/.local/bin/mrandr right
    control + alt + Right
        /home/mitch/.local/bin/mrandr left

---

For getting capslock -\> esc and held-capslock -\> super to work in sway, see https://gist.github.com/bendavis78/e8cc8371499b52ac276fbe864247fdb7. This will also suffice for any X11 window manager, or any other Wayland compositor that uses XKB instead of doing its own thing.

The file supescaps.diff currently contains the instructions in this gist but automated; run `doas patch < supescaps.diff` and it will magically work. You will have to re-do this every upgrade or reinstall of XKB/XCB/xorg/linux. Maybe make it a pacman hook?
