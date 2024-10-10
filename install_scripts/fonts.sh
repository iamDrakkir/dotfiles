#!/bin/bash

wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/FiraMono.zip
unzip FiraMono.zip -d FiraMono
rm FiraMono.zip
sudo mv FiraMono /usr/share/fonts/

wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.zip
unzip JetBrainsMono.zip -d JetBrainsMono
rm JetBrainsMono.zip
sudo mv JetBrainsMono /usr/share/fonts/

sudo fc-cache -fv
