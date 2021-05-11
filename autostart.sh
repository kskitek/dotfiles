#!/bin/sh

xsetroot -cursor_name left_ptr &
xset r rate 200 15

# wal -R &
# wal -i .dotfiles/background/current.jpg --saturate 0.6 -n -b 000000

# nitrogen --restore &
# feh --bg-scale .dotfiles/background/current.jpg
~/.fehbg &

setxkbmap pl &

compton &
dunst -conf ~/.dotfiles/dunstrc &

# ~/.dotfiles/bar/bar.sh &
# ~/.dropbox-dist/dropboxd &

sleep 10 && /opt/Drata\ Agent/drata-agent &

eval $(/usr/bin/gnome-keyring-daemon --start --components=gpg,pkcs11,secrets,ssh)
export GNOME_KEYRING_CONTROL GNOME_KEYRING_PID GPG_AGENT_INFO SSH_AUTH_SOCK
