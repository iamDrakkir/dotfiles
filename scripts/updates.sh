#!/bin/bash
# -----------------------------------------------------
# Define threshholds for color indicators
# -----------------------------------------------------
threshhold_green=0
threshhold_yellow=25
threshhold_red=100

# -----------------------------------------------------
# Determine the package manager
# -----------------------------------------------------
if command -v pacman &> /dev/null; then
    pkg_manager="pacman"
elif command -v apt &> /dev/null; then
    pkg_manager="apt"
elif command -v dnf &> /dev/null; then
    pkg_manager="dnf"
else
    echo "Unsupported package manager"
    exit 1
fi

# -----------------------------------------------------
# Calculate available updates
# -----------------------------------------------------
updates=0
if [ "$pkg_manager" = "pacman" ]; then
    if ! updates_arch=$(checkupdates 2> /dev/null | wc -l ); then
        updates_arch=0
    fi

    if ! updates_aur=$(trizen -Su --aur --quiet 2> /dev/null | wc -l); then
        updates_aur=0
    fi

    updates=$((updates_arch + updates_aur))
elif [ "$pkg_manager" = "apt" ]; then
    if ! updates=$(apt list --upgradable 2> /dev/null | grep -c 'upgradable'); then
        updates=0
    fi
elif [ "$pkg_manager" = "dnf" ]; then
    if ! updates=$(dnf check-update 2> /dev/null | grep -c '^[a-zA-Z0-9]'); then
        updates=0
    fi
fi

# -----------------------------------------------------
# Output in JSON format for Waybar Module custom-updates
# -----------------------------------------------------
css_class="green"
if [ "$updates" -gt $threshhold_yellow ]; then
    css_class="yellow"
fi

if [ "$updates" -gt $threshhold_red ]; then
    css_class="red"
fi

if [ "$updates" -gt $threshhold_green ]; then
    printf '{"text": "%s", "alt": "%s", "tooltip": "%s Updates", "class": "%s"}' "$updates" "$updates" "$updates" "$css_class"
else
    printf '{"text": "0", "alt": "0", "tooltip": "0 Updates", "class": "green"}'
fi
