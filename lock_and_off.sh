#!/bin/bash

# Lock the screen
swaylock -f &

# Turn off displays after 10 seconds if still locked
sleep 10
# Check if swaylock is still running
if pgrep -x swaylock > /dev/null; then
    hyprctl dispatch dpms off
fi
