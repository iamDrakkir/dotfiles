#!/bin/bash
JETBRAINSMONO_VERSION='v3.2.1'

wget https://github.com/ryanoasis/nerd-fonts/releases/download/${JETBRAINSMONO_VERSION}/JetBrainsMono.zip
unzip JetBrainsMono.zip -d ~/Downloads/JetBrainsMono
rm JetBrainsMono.zip
sudo mv ~/Downloads/JetBrainsMono /usr/share/fonts/

# sudo nala install fonts-noto fonts-font-awesome -y
sudo fc-cache -fv
