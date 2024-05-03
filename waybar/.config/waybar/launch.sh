#!/bin/bash
# -----------------------------------------------------
# Quit all running waybar instances
# -----------------------------------------------------
killall waybar
pkill waybar
sleep 0.1

# -----------------------------------------------------
# Loading the configuration
# -----------------------------------------------------
waybar -c ~/.config/waybar/themes/drakkir/config -s ~/.config/waybar/themes/drakkir/style.css &
