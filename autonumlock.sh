#!/bin/bash

state=$(hyprctl devices | grep -A 3 "keyboard" | grep "Num Lock" | grep -o "true")

if [ "$state" != "true" ]; then
    wtype --key num_lock
fi
