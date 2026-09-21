#!/usr/bin/env bash

# Drain hook input before exiting, then ring the controlling terminal. Ghostty
# turns BEL into an attention request when its tab is not focused, which makes
# the containing Hyprland workspace urgent (red in Waybar).
cat >/dev/null
printf '\a' > /dev/tty 2>/dev/null || true
