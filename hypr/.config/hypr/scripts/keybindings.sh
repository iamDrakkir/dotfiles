#!/bin/bash
config_file=$(cat ~/.config/hypr/conf/keybinding.conf)

# -----------------------------------------------------
# Parse keybindings
# -----------------------------------------------------
keybinds=$(grep -oP '(?<=bind = ).*' <<< $config_file)
keybinds=$(echo "$keybinds" | sed 's/$mainMod/SUPER/g'|  sed 's/,\([^,]*\)$/ = \1/' | sed 's/, exec//g' | sed 's/^,//g')

# -----------------------------------------------------
# Show keybindings in rofi
# -----------------------------------------------------
rofi -dmenu -i -replace -p "Keybinds" -config ~/.config/rofi/config-compact.rasi <<< "$keybinds"
