#!/bin/bash

clone-or-pull() {
  if [ -d $2 ]; then
    cd $2
    git pull
  else
    git clone "$1" $2
    cd $2
  fi
}

build-rofi-wayland() {
  clone-or-pull https://github.com/lbonn/rofi rofi-wayland
  mkdir build
  cd build
  meson setup .. --prefix=/usr
  ninja
  sudo ninja install
}

instalnl-dependencies() {
  sudo nala install -y \
    libxcb-util-dev \
    libxcb-cursor-dev \
    libxcb-xinerama0-dev \
    libstartup-notification0-dev \
    flex \
    bison
    # libglib2.0-dev \
    # libpango1.0-dev \
    # libxcb1-dev \
    # libxcb-ewmh-dev \
    # libxcb-icccm4-dev \
    # libxcb-xinerama0-dev \
    # libxcb-xkb-dev \
    # libxkbcommon-dev \
    # libxkbcommon-x11
}

mkdir ~/git
cd ~/git

instalnl-dependencies
build-rofi-wayland
