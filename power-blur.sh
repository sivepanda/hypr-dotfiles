#!/usr/bin/env bash

power_file=/sys/class/power_supply/AC/online
last_state=

while [[ -r $power_file ]]; do
    state=$(<"$power_file")
    if [[ $state != "$last_state" ]]; then
        if [[ $state == 1 ]]; then
            hyprctl eval 'hl.config({ decoration = { blur = { enabled = true } } })' >/dev/null
        else
            hyprctl eval 'hl.config({ decoration = { blur = { enabled = false } } })' >/dev/null
        fi
        last_state=$state
    fi
    sleep 2
done
