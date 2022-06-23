#!/bin/sh -e

red=6b3254
blue=325375

file=~/.dotfiles/background/current.jpg
# file=/tmp/screen_locked.png
# scrot $file
# mogrify -scale 10% -scale 1000% $file

notificationsState=$(dunstctl is-paused)

dunstctl set-paused true

i3lock -f -e -i $file --clock

#i3lock -f -e -i $file \
#  --pass-volume-keys --pass-media-keys \
#  --ringcolor=327475 --insidecolor=22222288 --keyhlcolor=0bb0b3 \
#  --insidewrongcolor=$red --ringwrongcolor=$red --bshlcolor=$red \
#  --insidevercolor=$blue --ringvercolor=$blue \
#  --clock --timecolor=000000

dunstctl set-paused $notificationsState
