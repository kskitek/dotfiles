#!/bin/bash

selection=`echo -e "\u23fe Suspend\n\uf011 Shutdown" | \
  rofi -dmenu -i \
  -width 6 -lines 2 \
  -font "3270SemiNarrow Nerd Font Mono 20"`

selection=`echo $selection | cut -d' ' -f2`
case $selection in
  Shutdown) echo "shutting down" ;;
  Suspend)
    ~/.dotfiles/scripts/lock.sh &
    sleep 0.5
    systemctl suspend
    ;;
esac
