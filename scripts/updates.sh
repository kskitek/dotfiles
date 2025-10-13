#!/bin/bash

last_upgrade=$(tac /var/log/pacman.log |
  grep -m 1 'full system upgrade' |
  cut -d ' ' -f 1 | tr -d '[]')

t=$(date +%s -d $last_upgrade)
now=$(date +%s)

days=$(( (now - t) / 86400 ))
if [ $days -gt 6 ]; then
  notify-send -u critical "System Update" "It's been $days days since your last system update."
fi
notify-send -u critical "System Update" "It's been $days days since your last system update."
