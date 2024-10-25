#!/bin/bash
ROFI_WAYLAND_VERSION='1.7.5+wayland3'

clone-or-pull() {
  if [ -d $2 ]; then
    pushd "$2" || { echo "Failed to change directory to $2"; exit 1; }
    git pull
    git checkout $3
    git submodule update --init --recursive
  else
    git clone --branch $3 "$1" $2 --recursive
    pushd "$2" || { echo "Failed to clone to $2"; exit 1; }
  fi
}

build-rofi-wayland() {
  clone-or-pull https://github.com/lbonn/rofi.git ~/git/rofi-wayland $ROFI_WAYLAND_VERSION
  mkdir build
  cd build
  meson setup .. --prefix=/usr
  ninja
  sudo ninja install
  popd
}

install-dependencies() {
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

install-dependencies
build-rofi-wayland
