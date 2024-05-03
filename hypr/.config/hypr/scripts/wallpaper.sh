#!/bin/bash
# Cache file for holding the current wallpaper
cache_file="$HOME/.cache/current_wallpaper"
rasi_file="$HOME/.cache/current_wallpaper.rasi"

# Create cache file if not exists
if [ ! -f $cache_file ] ;then
    touch $cache_file
    echo "$HOME/wallpaper/default.jpg" > "$cache_file"
fi

# Create rasi file if not exists
if [ ! -f $rasi_file ] ;then
    touch $rasi_file
    echo "* { current-image: url(\"$HOME/wallpaper/default.jpg\", height); }" > "$rasi_file"
fi

current_wallpaper=$(cat "$cache_file")

case $1 in
    # Load wallpaper from .cache of last session
    "init")
        if [ -f $cache_file ]; then
            wal -q -i $current_wallpaper
        else
            wal -q -i ~/wallpaper/
        fi
    ;;

    # Select wallpaper with rofi
    "select")
        selected=$( fd . --type f --extension jpg --extension jpeg --extension png "$HOME/wallpaper" | shuf | xargs -I {} basename {} | while read -r rfile;
        do
            echo -en "$rfile\x00icon\x1f$HOME/wallpaper/${rfile}\n"
        done | rofi -dmenu -replace -config ~/.config/rofi/config-wallpaper.rasi)
        if [ ! "$selected" ]; then
            echo "No wallpaper selected"
            exit
        fi
        wal -q -i ~/wallpaper/$selected
    ;;

    # Randomly select wallpaper
    *)
        wal -q -i ~/wallpaper/
    ;;

esac

# -----------------------------------------------------
# Load current pywal color scheme
# -----------------------------------------------------
source "$HOME/.cache/wal/colors.sh"
echo ":: Wallpaper: $wallpaper"

# -----------------------------------------------------
# Write selected wallpaper into .cache files
# -----------------------------------------------------
echo "$wallpaper" > "$cache_file"
echo "* { current-image: url(\"$wallpaper\", height); }" > "$rasi_file"

# -----------------------------------------------------
# get wallpaper image name
# -----------------------------------------------------
newwall=$(echo $wallpaper | sed "s|$HOME/wallpaper/||g")

# -----------------------------------------------------
# Reload waybar with new colors
# -----------------------------------------------------
~/.config/waybar/launch.sh

# -----------------------------------------------------
# Set the new wallpaper
# -----------------------------------------------------

wallpaper_engine=hyprpaper
if [ "$wallpaper_engine" == "swww" ] ;then
    echo ":: Using swww"
    transition_type="wipe"
    swww img $wallpaper \
      --transition-fps=60 \
      --transition-bezier .4,.7,.73,.6 \
      --transition-type="grow" \
      --transition-duration=1.2 \
      --transition-pos "$( hyprctl cursorpos )"
elif [ "$wallpaper_engine" == "hyprpaper" ] ;then
    # hyprpaper
    echo ":: Using hyprpaper"
    killall hyprpaper
    wal_tpl="\
      preload = ~/wallpaper/nature.jpg
      wallpaper = ,~/wallpaper/nature.jpg
      splash = false
      # preload = $wallpaper
      # wallpaper = ,$wallpaper
      # splash = false"
    echo "$wal_tpl" > $HOME/.config/hypr/hyprpaper.conf
    hyprpaper &
else
    echo ":: Wallpaper Engine disabled"
fi

# -----------------------------------------------------
# Send notification
# -----------------------------------------------------

if [ "$1" == "init" ] ;then
    echo ":: Init"
else
    sleep 1
    notify-send "Colors and Wallpaper updated" "with image $newwall"
fi

echo "DONE!"
