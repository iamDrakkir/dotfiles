#!/bin/bash

# Hyprland ecosystem
HYPRLAND_VERSION='0.40.0'
HYPRCURSOR_VERSION='0.1.8'
HYPRPAPER_VERSION='0.6.0'
HYPRIDLE_VERSION='0.1.2'
HYPRLOCK_VERSION='0.3.0'
HYPRPICKER_VERSION='0.1.0'
# dependencies
HYPRLANG_VERSION='0.5.0'
HYPRWAYLAND_SCANNER_VERSION='0.3.4'
XDG_DESKTOP_PORTAL_HYPRLAND_VERSION='0.1.0'
WAYLAND_VERSION='1.22.91'
WAYLAND_PROTOCOLS_VERSION='1.36'
LIBDISPLAY_INFO_VERSION='0.1.1'
TOMLPLUSPLUS_VERSION='3.4.0'
MESA_DRM_VERSION='2.4.120'
SDBUS_CPP_VERSION='1.6.0'


clone-or-pull() {
  if [ -d $2 ]; then
    cd $2
    git pull
  else
    git clone "$1" $2
    cd $2
  fi
}

build-tomlpp() {
  clone-or-pull https://github.com/marzer/tomlplusplus.git tomlplusplus
  mkdir build
  cd build
  meson setup .. --prefix=/usr
  ninja
  sudo ninja install
  cd ../..
}

build-libdrm() {
  clone-or-pull https://gitlab.freedesktop.org/mesa/drm.git drm
  mkdir build
  cd build
  meson setup .. --prefix=/usr
  ninja
  sudo ninja install
  cd ../..
}

build-wayland() {
  wget https://gitlab.freedesktop.org/wayland/wayland/-/releases/1.22.0/downloads/wayland-1.22.0.tar.xz
  tar -xvJf wayland-1.22.0.tar.xz

  cd wayland-1.22.0
  mkdir build
  cd build

  meson setup .. --prefix=/usr --buildtype=release -Ddocumentation=false
  ninja
  sudo ninja install

  cd ../..
}

build-wayland-protocols() {
  wget https://gitlab.freedesktop.org/wayland/wayland-protocols/-/releases/1.32/downloads/wayland-protocols-1.32.tar.xz
  tar -xvJf wayland-protocols-1.32.tar.xz
  cd wayland-protocols-1.32

  mkdir build
  cd build

  meson setup --prefix=/usr --buildtype=release
  ninja
  sudo ninja install

  cd ../..

  # we also build hyprland protocols here
  clone-or-pull https://github.com/hyprwm/hyprland-protocols.git hyprland-protocols

  mkdir build
  cd build

  meson setup --prefix=/usr --buildtype=release
  ninja
  sudo ninja install

  cd ../..
}


build-hypwayland-scanner() {
  clone-or-pull https://github.com/hyprwm/hyprwayland-scanner

  cmake -DCMAKE_INSTALL_PREFIX=/usr -B build
  cmake --build build -j `nproc`

  sudo cmake --install build

  cd ..
}

build-libdisplayinfo() {
  wget https://gitlab.freedesktop.org/emersion/libdisplay-info/-/releases/0.1.1/downloads/libdisplay-info-0.1.1.tar.xz
  tar -xvJf libdisplay-info-0.1.1.tar.xz

  cd libdisplay-info-0.1.1/

  mkdir build
  cd build

  meson setup --prefix=/usr --buildtype=release
  ninja

  sudo ninja install

  cd ../..
}

build-sdbus-cpp() {
  clone-or-pull https://github.com/Kistler-Group/sdbus-cpp.git sdbus-cpp
  git checkout v1.6.0
  mkdir build
  cd build
  cmake .. -DCMAKE_BUILD_TYPE=Release
  make
  sudo make install
  cd ../..
}

build-deps () {
  sudo apt-get install -y nala
  sudo nala install -y meson wget build-essential ninja-build cmake-extras cmake gettext gettext-base fontconfig libfontconfig-dev \
    libffi-dev libxml2-dev libxkbcommon-x11-dev libxkbregistry-dev libxkbcommon-dev libpixman-1-dev libudev-dev libseat-dev seatd \
    libxcb-dri3-dev libvulkan-dev libvulkan-volk-dev vulkan-utility-libraries-dev libvkfft-dev libgulkan-dev libegl-dev libgles2 \
    libegl1-mesa-dev glslang-tools libinput-bin libinput-dev libxcb-composite0-dev libavutil-dev libavcodec-dev libavformat-dev \
    libxcb-ewmh2 libxcb-ewmh-dev libxcb-icccm4-dev libxcb-present-dev libxcb-render-util0-dev libxcb-res0-dev libxcb-xinput-dev \
    libpango1.0-dev xdg-desktop-portal-wlr hwdata libx11-xcb-dev libxdamage-dev libxcomposite-dev libxtst-dev libliftoff-dev \
    libwlroots-dev libpipewire-0.3-dev qt6-base-dev

  build-tomlpp
  build-libdrm
  build-wayland
  build-wayland-protocols
  build-hypwayland-scanner
  build-libdisplayinfo
  build-sdbus-cpp
}

## Building Hyprland
build-hyprland () {
  wget https://github.com/hyprwm/Hyprland/releases/download/v0.35.0/source-v0.35.0.tar.gz
  tar -xvf source-v0.35.0.tar.gz

  cd hyprland-source/

  make all && sudo make install

  cd ../..
}

builtHyprlang=0
build-hyprlang() {
  if [ $builtHyprlang -eq 1 ]; then
    clone-or-pull https://github.com/hyprwm/hyprlang.git hyprlang

    cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build
    cmake --build ./build --config Release --target hyprlang -j`nproc 2>/dev/null || getconf NPROCESSORS_CONF`
    sudo cmake --install ./build
    cd ..
    builtHyprlang=1
  fi
}

build-hyprpaper() {
  build-hyprlang

  clone-or-pull https://github.com/hyprwm/hyprpaper hyprpaper
  cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build
  cmake --build ./build --config Release --target hyprpaper -j`nproc 2>/dev/null || getconf NPROCESSORS_CONF`
  sudo cmake --install ./build/
  cd ..
}

build-hypridle() {
  build-hyprlang

  clone-or-pull https://github.com/hyprwm/hypridle.git hypridle

  cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -S . -B ./build
  cmake --build ./build --config Release --target hypridle -j`nproc 2>/dev/null || getconf NPROCESSORS_CONF`
  sudo cmake --install build
  cd ..
}

build-xdg-desktop-portal-hyprland() {
  sudo nala install -y qt6-wayland
  clone-or-pull https://github.com/hyprwm/xdg-desktop-portal-hyprland.git xdg-desktop-portal-hyprland

  cmake -DCMAKE_INSTALL_LIBEXECDIR=/usr/lib -DCMAKE_INSTALL_PREFIX=/usr -B build
  cmake --build build
  sudo cmake --install build
  cd ..
}

build-hyprlock() {
  clone-or-pull https://github.com/hyprwm/hyprlock.git hyprlock

  cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -S . -B ./build
  cmake --build ./build --config Release --target hyprlock -j`nproc 2>/dev/null || getconf NPROCESSORS_CONF`
  sudo cmake --install build
  cd ..
}

build-hyprpicker() {
  clone-or-pull https://github.com/hyprwm/hyprpicker hyprpicker

  cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build
  cmake --build ./build --config Release --target hyprpicker -j`nproc 2>/dev/null || getconf NPROCESSORS_CONF`
  sudo cmake --install ./build
  cd ..
}

build-hyprcursor() {
  clone-or-pull https://github.com/hyprwm/hyprcursor hyprcursor

  cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build
  cmake --build ./build --config Release --target all -j`nproc 2>/dev/null || getconf NPROCESSORS_CONF`
  sudo cmake --install build
  cd ..
}

mkdir ~/HyprSource
cd ~/HyprSource

build-deps
build-hyprland
build-hyprpaper
build-hypridle
build-hyprlock
build-hyprpicker
build-hyprcursor
build-xdg-desktop-portal-hyprland

