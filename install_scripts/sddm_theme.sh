#!/bin/bash

pushd ~/Downloads
# Download the Catppuccin Mocha theme for SDDM
curl -L https://github.com/catppuccin/sddm/releases/download/v1.0.0/catppuccin-mocha.zip -o sddm_catppuccin.zip

# install deps
sudo apt install --no-install-recommends qml-module-qtquick-layouts qml-module-qtquick-controls2 libqt6svg6 qml-module-qtquick-window2 -y

# Unzip the downloaded theme
unzip sddm_catppuccin.zip -d catppuccin_theme

# Define the target SDDM theme directory
TARGET_DIR="/usr/share/sddm/themes"

# Create the target directory if it doesn't exist
sudo mkdir -p "$TARGET_DIR"

# Copy the extracted theme to the target directory
sudo cp -r catppuccin_theme/* "$TARGET_DIR"

# Define the SDDM config file (adjust if different on your system)
SDDM_FILE="/etc/sddm.conf"

# Generate default config if missing
if [ ! -f "$SDDM_FILE" ]; then
  echo "SDDM config not found. Generating default config..."
  sudo sddm --example-config | sudo tee "$SDDM_FILE" >/dev/null
fi

# Define the theme name and the config line to be added
THEME_NAME="catppuccin-mocha"
THEME_LINE="Current=$THEME_NAME"

# Ensure the [Theme] section exists in the config
if ! grep -q '^\[Theme\]' "$SDDM_FILE"; then
  echo -e "\n[Theme]" | sudo tee -a "$SDDM_FILE" >/dev/null
fi

# Check if the 'Current=' line exists under the [Theme] section
if grep -q '^Current=' "$SDDM_FILE"; then
  # Replace the existing line
  sudo sed -i "s|^Current=.*|$THEME_LINE|" "$SDDM_FILE"
else
  # Add the theme line under the [Theme] section
  sudo sed -i "/^\[Theme\]/a $THEME_LINE" "$SDDM_FILE"
fi

popd
