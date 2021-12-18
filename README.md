# User-level configuration files

Hi. Welcome to my dotfiles repository.

Everything in here is developed on pretty much a single fixed arch/artix system, but is designed to be declarative and deployable.
So far this only extends to UNIX-like platforms, but I will eventually figure out Windows file path resolution.

There's a lot of stuff in [.config/nvim](.config/nvim) as that's where I spend a lot of my time, so be sure and check that out.

For shell configs, look in [.config/zsh](.config/zsh). For scripts, [.local/bin](.local/bin).

There's a whole bunch of other stuff too, which I'll eventually go and document.

---

## Self-documenting code does not exist

But some day, there will be an index.md and correspondingly auto-generated index.html in every sub-directory; this will essentially form a lazy man's web interface to his files. But until then, you're just gonna have to look at the code and figure out what it does yourself.

---

### The terminal

Beyond handling true-color and UTF-8 nerd fonts, any terminal is sufficient in my book.
That said, I focus this config on alacritty because anything worth doing is worth being lazy and efficient about.
Alacritty is fast, it's the default on sway, it's in a lot of repos, and it's one of the few Rust programs that actually has other perks for using-- such as a (weird) built-in vi mode and search.
I could make Kitty work almost as well, or even something like gnome-terminal... but alacritty is already where I want it.

Also the reason I got so invested in alacritty in the first place was because the default colors were so ugly. More about that later...

### The shell

I run ZSH. It's decently fast, POSIX compliant, and has _zillions_ of options and menues and plugins.

I have copied Luke Smith's config layout of a .zprofile linked to its xdg-compliant location and setting `$ZDOTDIR` to `~/.config/zsh` because having a clean `$HOME` is nice.
the `.zshrc` sources `functions.zsh` and `aliases.zsh`, and will on first run attempt to install `zplug` for a few fun extensions.

Upon entering the shell it will run, among silent things, `neofetch`. While there are sort of alternatives, nothing quite hits the spot that neofetch does, at least for me.
This may be partially because I have extended neofetch slightly in my config.conf:

- The "Packages" function is now asynchronous to work better on Fedora or other slow package managers (fight me)

- There is now a line for the current tmux pane if the current session is in one (otherwise says "N/A")

- When paired with my `.zshrc`, it now prints out the previous value of the TERM variable (before tmux sets it to `screen`)

- It will print out your currently-booted init system. The Artix inits work as expected, systemd insults you, and anything else (such as Android or Windows) spews nonsense. (Need to double check the behavior of Windows. Perhaps I should poll for `svchost.exe`?)

### The coreutil aliases

`exa`, if available, replaces `ls`. GNU (or even BusyBox) `ls` is by no means bad, but I like `exa`'s colors better. Also mandatory reminder that it's written in rust.

`rg` (ripgrep) replaces `grep`. Honestly it's rather pointless because I'm not using any of `rg`'s extra features, but hey. Rust.

`tree` is now `exa -T` because colors. Note that if you want `pass` for password management you still need the real `tree` installed.

`sl` I like to have installed so I don't mistype `ls`.

`dc` the calculator is worthess. If I type `dc` it is by accident. Thus, it's remapped to a special surprise here.

### The Editor

Neovim is great. Not minimal at all, and every day there are more legacy features in it that need refactoring or replacement,
but they're doing a fantastic job and they've built up a wonderful ecosystem.

I don't actually mess that much with it. Just a custom color scheme, a few ease-of-use and eyecandy plugins, and an ever-growing mental model of how the thing works.
You may find some fragments of `coc.nvim`, `cmp`, or LSP configuration scattered about. At present none of it works because I haven't gotten to fixing it yet.

---

| This is | a table  |
| ------- | -------- |
| which I | am using |
| to prove | they |
| can | exist |

# Notes on mrandr:

Use it as you would `xrandr -o`. E.G., `mrandr right` rotates the screen clockwise by 90 degrees. Et cetera.

There is a comment at the beginning of the executable linking to an extremely helpful Ubuntu Wiki page on the subject, so check that out too.

To make it run automatically on gyroscope/accelerometer events, learn how ACPI works or something.

Instead, bind it to a hotkey. On Xorg/xmonad I have it bound to ctrl+alt+arrowkey via sxhkd (https://wiki.archlinux.org/title/sxhkd):

    control + alt + Up
        /home/mitch/.local/bin/mrandr inverted
    control + alt + Down
        /home/mitch/.local/bin/mrandr normal
    control + alt + Left
        /home/mitch/.local/bin/mrandr right
    control + alt + Right
        /home/mitch/.local/bin/mrandr left

Or for sway/i3:

    bindsym $mod+Left exec "~/.local/bin/mrandr right"
    bindsym $mod+Down exec "~/.local/bin/mrandr normal"
    bindsym $mod+Up exec "~/.local/bin/mrandr inverted"
    bindsym $mod+Right exec "~/.local/bin/mrandr left"

---

~~For getting capslock -\> esc and held-capslock -\> super to work in sway, see https://gist.github.com/bendavis78/e8cc8371499b52ac276fbe864247fdb7. This will also suffice for any X11 window manager, or any other Wayland compositor that uses XKB instead of doing its own thing.~~

~~The file .local/share/supescaps.diff currently contains the instructions in this gist but automated; run `doas patch < .local/share/supescaps.diff` and it might magically work. You will have to re-do this every upgrade or reinstall of XKB/XCB/xorg/linux. Maybe make it a pacman hook?~~

~~^^^ the above doesn't work because I'm an idiot and can't write patch files. Should probably work it into that shell script that will also auto-detect the package manager and install everything automatically.~~

As of 2020, xkb accepts user-specific keyboard patches. Modifying system files is no longer needed, and was always bad practice. Please don't do it either.
