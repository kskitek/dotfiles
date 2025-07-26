#!/bin/bash

TMP_WS=99
CURRENT_WS=$(hyprctl activeworkspace -j | jq .id)

hyprctl dispatch movetoworkspace $TMP_WS
hyprctl dispatch workspace $CURRENT_WS
hyprctl dispatch movetoworkspace $CURRENT_WS
