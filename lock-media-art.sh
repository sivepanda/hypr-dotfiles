#!/usr/bin/env bash

artist=$(playerctl metadata artist 2>/dev/null)
title=$(playerctl metadata title 2>/dev/null)
arturl=$(playerctl metadata mpris:artUrl 2>/dev/null)

[[ -n $arturl ]] || exit 0

artist=${artist:-"Unknown Artist"}
title=${title:-"Unknown Title"}
glyphs=$(printf '%s' "$artist$title" | tr -cd '[:alnum:]' | tr '[:lower:]' '[:upper:]')

art_img=$(mktemp)
trap 'rm -f "$art_img"' EXIT

if [[ $arturl == file://* ]]; then
    cp "${arturl#file://}" "$art_img" 2>/dev/null || exit 0
else
    curl -fsSL -o "$art_img" "$arturl" 2>/dev/null || exit 0
fi

chafa -f symbols -c full --fg-only --animate off --stretch --symbols "[$glyphs]" -w 9 -s 47x18 "$art_img" 2>/dev/null | "$HOME/.config/waybar/custom_modules/ansi2pango.sh"
