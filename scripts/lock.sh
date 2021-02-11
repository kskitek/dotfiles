#!/bin/sh -e

file=/tmp/screen_locked.png
red=6b3254
blue=325375

scrot $file
mogrify -scale 10% -scale 1000% $file
i3lock -f -e -i $file \
  --pass-volume-keys --pass-media-keys \
  --ringcolor=327475 --insidecolor=22222288 --keyhlcolor=0bb0b3 \
  --insidewrongcolor=$red --ringwrongcolor=$red --bshlcolor=$red \
  --insidevercolor=$blue --ringvercolor=$blue \
  --clock --timecolor=000000
rm $file
