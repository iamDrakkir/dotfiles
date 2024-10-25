#!/bin/bash
WAYBAR_VERSION='0.11.0'

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

build-waybar() {
  clone-or-pull https://github.com/Alexays/Waybar.git ~/git/waybar $WAYBAR_VERSION
  mkdir build
  cd build
  meson setup .. --prefix=/usr
  ninja -C build
  sudo ninja install
  popd
}

install-dependencies() {
  sudo nala install -y \
    clang-tidy \
    gobject-introspection \
    libdbusmenu-gtk3-dev \
    libevdev-dev \
    libfmt-dev \
    libgirepository1.0-dev \
    libgtk-3-dev \
    libgtkmm-3.0-dev \
    libinput-dev \
    libjsoncpp-dev \
    libmpdclient-dev \
    libnl-3-dev \
    libnl-genl-3-dev \
    libpulse-dev \
    libsigc++-2.0-dev \
    libspdlog-dev \
    libwayland-dev \
    scdoc \
    upower \
    libxkbregistry-dev
}

install-dependencies
build-waybar
