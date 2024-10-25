#!/bin/bash

# Use parameter expansion for DOTFILES with a default value
DOTFILES="${DOTFILES:-$HOME/.dotfiles}"

# Ensure stow is installed
sudo apt install stow -y

# Navigate to the DOTFILES directory, exit if it fails
pushd "$DOTFILES" || { echo "Failed to change directory to $DOTFILES"; exit 1; }

# Generate a list of directories
STOW_FOLDERS=$(find . -maxdepth 1 -mindepth 1 -type d -not -name '.*' -exec basename {} \;)

# Loop through each folder and apply stow commands
for folder in $STOW_FOLDERS; do
    read -p "Do you want to stow the folder '$folder'? [y/N] " confirm
    if [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]]; then
        stow -D "$folder"
        stow "$folder"
    else
        echo "Skipping '$folder'"
    fi
done

# Return to the original directory
popd || { echo "Failed to return to the original directory"; exit 1; }
