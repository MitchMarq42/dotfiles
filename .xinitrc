#!/bin/sh 
nitrogen --restore
picom -b
gnome-keyring-daemon
xsetroot -cursor_name left_ptr
xset r rate 200 30
# setxkbmap -option caps:escape
localectl set-x11-keymap us "" "" caps:escape
xbindkeys

id=$(
    xinput list |
	grep -i touchpad |
	sed -nE 's/^.*id=([0-9]*).*$/\1/p'
  )
prop=$(
    xinput list-props $id |
	grep -i natural |
	grep -vi default |
	sed -nE 's/^.*\(([0-9]*)\).*$/\1/p'
    )
xinput set-prop $id $prop 1

dunst &
polybar &
xfce4-power-manager &
fusuma &
# sxhkd &
# alacritty &
exec bspwm
# exec xmonad
