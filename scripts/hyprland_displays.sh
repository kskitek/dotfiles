#!/bin/sh

monitors=$(hyprctl monitors | rg 'Monitor ' | sed -E 's/Monitor (.*)\(.*\):/\1/')

# TODO select a monitor
# exit if not selected

# TODO add an emergency shortcut to enable all monitors with "$m,preferred,auto,1"

for m in $monitors; do
  if [[ "$m" = "$selected" ]]; then
    continue
  fi
  hyprctl keyword monitor "$m,disable"
done

settings=$(cat ~/.config/hypr/hyprland.conf | rg "monitor=$selected.*" | cut -d'=' -f2)
hyprctl keyword monitor "$settings"

for i in {0..9}; do
  hyprctl dispatch moveworkspacetomonitor "$i $selected"
done
