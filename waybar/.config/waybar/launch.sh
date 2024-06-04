#!/bin/bash
# Quit all running waybar instances
killall waybar
pkill waybar
sleep 0.1

# Loading the configuration
waybar -c ~/.config/waybar/config.jsonc -s ~/.config/waybar/style.css -l debug &
