#!/bin/bash
level=$(cat /sys/class/power_supply/BAT0/capacity)
notify-send -u low "Battery level" "Battery level is at ${level}%" -i battery

