#!/bin/bash

# TODO check upower -e
#  and upower -i /org/freedesktop/UPower/devices/battery_BAT0
# maybe this is a way to get headphone battery status too

# TODO use tail -f /sys/class/power_supply/BAT0/status to monitor plug/unplug events

level=$(cat /sys/class/power_supply/BAT0/capacity)
if [ "$level" -le 10 ]; then
    notify-send -u critical "Battery low" "Battery level is at ${level}%!" -i battery-caution
elif [ "$level" -le 20 ]; then
    notify-send -u normal "Battery low" "Battery level is at ${level}%!" -i battery-low
elif [ "$level" -le 30 ]; then
    notify-send -u low "Battery warning" "Battery level is at ${level}%!" -i battery-good
fi
