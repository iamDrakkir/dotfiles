#!/bin/bash
# -----------------------------------------------------
# Quit all running waybar instances
# -----------------------------------------------------
killall waybar
pkill waybar
sleep 0.2

# -----------------------------------------------------
# Loading the configuration
# -----------------------------------------------------

waybar -c ~/.config/waybar/themes/ml4w/config -s ~/.config/waybar/themes/ml4w/style.css &
