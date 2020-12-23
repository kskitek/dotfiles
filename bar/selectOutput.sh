#!/bin/bash

selection=`pamixer --list-sinks | tail -n +2 |  cut -d' ' -f1,3- | tr -d '"' |
  rofi -dmenu -i \
  -p "Select sound output" \
  -width 20 -lines 5 \
  -font "3270SemiNarrow Nerd Font Mono 20"`

if [ $? -eq 0 ]; then
  sinkNo=`echo $selection | cut -d' ' -f1`
  pactl set-default-sink $sinkNo
fi
