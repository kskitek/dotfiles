#!/bin/bash

BAR_FIFO=$1
dunstctl set-paused toggle
echo "N$(dunstctl is-paused)" > $BAR_FIFO
