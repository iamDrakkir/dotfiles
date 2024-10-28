#!/bin/bash

clone-or-pull() {
  if [ -d "$2" ]; then
    pushd "$2" || { echo "Failed to change directory to $2"; exit 1; }
    git pull
    git submodule update --init --recursive
  else
    git clone "$1" "$2" --recursive
    pushd "$2" || { echo "Failed to clone to $2"; exit 1; }
  fi
}

clone-or-pull https://github.com/catppuccin/grub.git ~/Downloads/catppuccin_grub

# Create the target directory if it doesn't exist
TARGET_DIR="/usr/share/grub/themes/"
sudo mkdir -p "$TARGET_DIR"

# Copy files to the target directory
sudo cp -r src/* "$TARGET_DIR"
# Define the theme line
THEME_LINE='GRUB_THEME="/usr/share/grub/themes/catppuccin-mocha-grub-theme/theme.txt"'
GRUB_FILE="/etc/default/grub"

# Check if the GRUB_THEME line exists
if grep -q '^GRUB_THEME=' "$GRUB_FILE"; then
  # Replace the existing GRUB_THEME line
  sudo sed -i "s|^GRUB_THEME=.*|$THEME_LINE|" "$GRUB_FILE"
else
  # Add the GRUB_THEME line
  echo "$THEME_LINE" | sudo tee -a "$GRUB_FILE" > /dev/null
fi

GRUB_DISABLE_MEMTEST='GRUB_DISABLE_MEMTEST=true'
if grep -q '^GRUB_DISABLE_MEMTEST=' "$GRUB_FILE"; then
  # Replace the existing GRUB_DISABLE_MEMTEST line
  sudo sed -i "s|^GRUB_DISABLE_MEMTEST=.*|$GRUB_DISABLE_MEMTEST|" "$GRUB_FILE"
else
  # Add the GRUB_DISABLE_MEMTEST line
  echo "$GRUB_DISABLE_MEMTEST" | sudo tee -a "$GRUB_FILE" > /dev/null
fi

sudo grub-mkconfig -o /boot/grub/grub.cfg

popd
