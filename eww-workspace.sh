#!/usr/bin/env bash

eww=/home/siven/eww/target/release/eww
config=/home/siven/.config/eww

exec 9>"${XDG_RUNTIME_DIR:-/tmp}/eww-workspace.lock"
flock -n 9 || exit 0

set_windows() {
    if [[ $1 == 1 ]]; then
        "$eww" --config "$config" open-many calendar-widget media-widget >/dev/null 2>&1
    else
        "$eww" --config "$config" close calendar-widget >/dev/null 2>&1 || true
        "$eww" --config "$config" close media-widget >/dev/null 2>&1 || true
    fi
}

set_windows "$(hyprctl -j activeworkspace | jq -r .name)"

socket="${XDG_RUNTIME_DIR:-/run/user/$(id -u)}/hypr/${HYPRLAND_INSTANCE_SIGNATURE}/.socket2.sock"
while true; do
    socat -U - "UNIX-CONNECT:$socket" 2>/dev/null | while IFS= read -r event; do
        case $event in
            workspace\>\>*) set_windows "${event#workspace>>}" ;;
            workspacev2\>\>*) set_windows "${event#*,}" ;;
        esac
    done
    sleep 1
done
