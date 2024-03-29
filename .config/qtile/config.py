# My Qtile config. It's kinda bad.

# Imports
# import os  # Irrelevant because we don't really care about stuff
from typing import List  # noqa: F401

from libqtile import bar, layout, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
# from libqtile.utils import guess_terminal

mod = "mod4"
terminal = "gnome-terminal"

keys = [
        # Switch between windows
        # Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
        # Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
        # Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
        # Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
        Key([mod], "space", lazy.layout.next(),
            desc="Move window focus to other window"),
        # MonadTall keys. Might be bad.
        Key([mod], "j", lazy.layout.next()),
        Key([mod], "k", lazy.layout.previous()),
        Key([mod], "h", lazy.layout.shrink_main()),  # Move vert split left
        Key([mod], "l", lazy.layout.grow_main()),  # Move vert split right
        Key([mod, "shift"], "h", lazy.layout.swap_left()),
        Key([mod, "shift"], "l", lazy.layout.swap_right()),
        # Key([mod, "shift"], "j", lazy.layout.shuffle_down()),
        # Key([mod, "shift"], "k", lazy.layout.shuffle_up()),
        Key([mod], "n", lazy.layout.normalize()),
        Key([mod], "o", lazy.layout.maximize()),
        Key([mod, "shift"], "space", lazy.layout.flip()),

        # Move windows  up/down in current stack.
        # Moving out of range in Columns layout will create new column.
        Key([mod, "shift"], "j", lazy.layout.shuffle_down(),
            desc="Move window down"),
        Key([mod, "shift"], "k", lazy.layout.shuffle_up(),
            desc="Move window up"),

        # Grow windows. If current window is on the edge of screen and
        # direction will be to screen edge - window would shrink.
        Key([mod, "control"], "j", lazy.layout.grow_down(),
            desc="Grow window down"),
        Key([mod, "control"], "k", lazy.layout.grow_up(),
            desc="Grow window up"),
        Key([mod], "n", lazy.layout.normalize(),
            desc="Reset all window sizes"),

        # Toggle between split and unsplit sides of stack.
        # Split = all windows displayed
        # Unsplit = 1 window displayed, like Max layout, but still with
        # multiple stack panes
        Key([mod, "shift"], "Return", lazy.layout.toggle_split(),
            desc="Toggle between split and unsplit sides of stack"),
        Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),

        # Toggle between different layouts as defined below
        Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
        Key([mod, "shift"], "c", lazy.window.kill(), desc="Kill focused window"),

        Key([mod], "q", lazy.restart(), desc="Restart Qtile"),
        Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
        Key([mod], "r", lazy.spawncmd(),
            desc="Spawn a command using a prompt widget"),
        ]

groups = [Group(i) for i in "123456789"]

for i in groups:
    keys.extend([
        # mod1 + letter of group = switch to group
        Key([mod], i.name, lazy.group[i.name].toscreen(),
            desc="Switch to group {}".format(i.name)),

        # mod1 + shift + letter of group = switch to & move focused window to group
        Key([mod, "shift"], i.name, lazy.window.togroup(i.name, switch_group=True),
            desc="Switch to & move focused window to group {}".format(i.name)),
        # Or, use below if you prefer not to switch to that group.
        # # mod1 + shift + letter of group = move focused window to group
        # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
        #     desc="move focused window to group {}".format(i.name)),
        ])

layouts = [
        # layout.Columns(),
        # layout.Max(),
        # Try more layouts by unleashing below layouts.
        # layout.Stack(num_stacks=2),
        # layout.Bsp(),
        # layout.Matrix(),
        layout.MonadTall(
            border_focus='#ff0000',
            border_normal='#a0a0a0',
            border_width=1,
            new_client_position="top",
            ),
        # layout.MonadWide(),
        # layout.RatioTile(),
        # layout.Tile(),
        # layout.TreeTab(),
        # layout.VerticalTile(),
        # layout.Zoomy(),
        ]

widget_defaults = dict(
        font='MesloLGS NF Bold',
        fontsize=15,
        padding=1,
        )
extension_defaults = widget_defaults.copy()

screens = [
        Screen(
            # top=bar.Bar(
            #     [
            #         # # widget.CurrentLayout(),
            #         # widget.GroupBox(**widget_defaults),
            #         # # widget.Prompt(),
            #         # widget.WindowName(
            #         #     center_aligned=True,
            #         #     ),
            #         # widget.Chord(
            #         #     chords_colors={
            #         #         'launch': ("#ff0000", "#ffffff"),
            #         #         },
            #         #     name_transform=lambda name: name.upper(),
            #         #     ),
            #         # # widget.TextBox("default config", name="default"),
            #         # # widget.TextBox(),
            #         # # widget.Systray(),
            #         # widget.Clock(format='%I:%M %p'),
            #         # # widget.QuickExit(),
            #         ],
            #     29,
            #     background="#303030",
            #     opacity=0.8,
            #     ),
            ),
        ]

# Drag floating layouts.
mouse = [
        Drag([mod], "Button1", lazy.window.set_position_floating(),
             start=lazy.window.get_position()),
        Drag([mod], "Button3", lazy.window.set_size_floating(),
             start=lazy.window.get_size()),
        Click([mod], "Button2", lazy.window.bring_to_front())
        ]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
follow_mouse_focus = True
bring_front_click = True
cursor_warp = True
floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    *layout.Floating.default_float_rules,
    Match(wm_class='confirmreset'),  # gitk
    Match(wm_class='makebranch'),  # gitk
    Match(wm_class='maketag'),  # gitk
    Match(wm_class='ssh-askpass'),  # ssh-askpass
    Match(title='branchdialog'),  # gitk
    Match(title='pinentry'),  # GPG key password entry
    # custom things
    Match(title='*Minibuf-0'),
    ])
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# layout.Ignore(ignore_rules=[
#     *layout.Ignore.default_ignore_rules,
#     Match(wm_class='xfce4-panel'),
# ])

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "MitchWM"

# Do the things that need to be done from shell 'cause I'm lazy (VERY BROKEN)
# os.system("swaybg -i ~/.local/share/backgrounds/mojave_midnight.jpg")
