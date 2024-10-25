#!/bin/bash
cache_file="$HOME/.cache/current_wallpaper.jpg"
rasi_file="$HOME/.cache/current_wallpaper.rasi"
wallpaper_folder="$HOME/wallpaper/"
default_wallpaper="$wallpaper_folder/flying-comets-clouds.jpg"

# Create cache file if not exists
echo "1"
if [ ! -f $cache_file ] ;then
    ln -s "$default_wallpaper" "$cache_file"
fi
if [ ! -f $rasi_file ] ;then
    touch $rasi_file
    echo "* { current-image: url(\"$default_wallpaper\", height); }" > "$rasi_file"
fi
echo "2"

case $1 in
    # Load wallpaper from .cache of last session
    "init")
        exit
    ;;

    # Select wallpaper with rofi
    "select")
        selected=$( find "$wallpaper_folder" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) -exec basename {} \; | sort -R | while read rfile
        do
            echo -en "${rfile}\x00icon\x1f$wallpaper_folder${rfile}\n"
        done | rofi -dmenu -replace -config $HOME/.config/rofi/config-wallpaper.rasi)
        echo "Selected wallpaper" "$selected"
        if [ ! "$selected" ]; then
            echo "No wallpaper selected"
            exit
        fi
        wallpaper=$wallpaper_folder$selected
    ;;

    # Randomly select wallpaper
    *)
        selected=$(find "$wallpaper_folder" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) | shuf -n 1)
        echo "Randomly selected wallpaper" "$selected"
        wallpaper=$selected
    ;;
esac


# Write selected wallpaper into .cache files
ln -s "$wallpaper" "$cache_file" -f
echo "* { current-image: url(\"$wallpaper\", height); }" > "$rasi_file"


# Set the new wallpaper
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
    echo ":: Using hyprpaper"
    killall hyprpaper
    sleep 0.1
    hyprpaper &
else
    echo ":: Wallpaper Engine disabled"
fi

# get wallpaper image name
newwall=$(readlink -f $cache_file | sed "s|$HOME/wallpaper/||g")

# Send notification
if [ "$1" == "init" ] ;then
    echo ":: Init"
else
    sleep 1
    notify-send "Colors and Wallpaper updated" "with image $newwall"
fi

echo "DONE!"
