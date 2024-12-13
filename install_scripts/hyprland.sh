#!/bin/bash

# Hyprland ecosystem
HYPRLAND_VERSION='v0.45.2'
HYPRCURSOR_VERSION='v0.1.9'
HYPRPAPER_VERSION='v0.7.1'
HYPRIDLE_VERSION='v0.1.2'
HYPRLOCK_VERSION='v0.4.1'
HYPRPICKER_VERSION='v0.4.1'
HYPRUTILS_VERSION='v0.2.3'

# Dependencies
AQUAMARINE_VERSION='v0.4.2'
LIBINPUT_VERSION='1.26.2'
LIBXCB_ERROR_VERSION='xcb-util-errors-1.0.1'
HYPRLANG_VERSION='v0.5.2'
HYPRlAND_PROTOCOLS_VERSION='v0.4.0'
HYPRWAYLAND_SCANNER_VERSION='v0.4.2'
XDG_DESKTOP_PORTAL_HYPRLAND_VERSION='v1.3.6'
WAYLAND_VERSION='1.23.1'
WAYLAND_PROTOCOLS_VERSION='1.37'
TOMLPLUSPLUS_VERSION='v3.4.0'
SDBUS_CPP_VERSION='1.6.0'

# Screenshot annotation tool
SATTY_VERSION='v0.14.0'


confirm() {
  read -r -p "$1 [Y/n] " response
  case "$response" in
    [nN][oO]|[nN])
      false
      ;;
    *)
      true
      ;;
  esac
}

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

build-tomlpp() {
  clone-or-pull https://github.com/marzer/tomlplusplus.git tomlplusplus $TOMLPLUSPLUS_VERSION
  mkdir build
  cd build
  meson setup .. --prefix=/usr
  ninja
  sudo ninja install
  popd
}

build-wayland() {
  clone-or-pull https://gitlab.freedesktop.org/wayland/wayland.git wayland $WAYLAND_VERSION
  mkdir build
  cd build
  meson setup .. --prefix=/usr --buildtype=release -Ddocumentation=false
  ninja
  sudo ninja install
  popd
}

build-wayland-protocols() {
  clone-or-pull https://gitlab.freedesktop.org/wayland/wayland-protocols.git wayland-protocols $WAYLAND_PROTOCOLS_VERSION
  mkdir build
  cd build
  meson setup --prefix=/usr --buildtype=release
  ninja
  sudo ninja install
  popd
}

build-hyprland-protocols() {
  clone-or-pull https://github.com/hyprwm/hyprland-protocols.git hyprland-protocols $HYPRlAND_PROTOCOLS_VERSION
  mkdir build
  cd build
  meson setup --prefix=/usr --buildtype=release
  ninja
  sudo ninja install
  popd
}

build-hyprutils() {
  clone-or-pull https://github.com/hyprwm/hyprutils.git hyprutils $HYPRUTILS_VERSION
  cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build
  cmake --build ./build --config Release --target all -j`nproc 2>/dev/null || getconf _NPROCESSORS_CONF`
  sudo cmake --install build
  popd
}

build-hyprwayland-scanner() {
  clone-or-pull https://github.com/hyprwm/hyprwayland-scanner hyprwayland-scanner $HYPRWAYLAND_SCANNER_VERSION
  sudo nala install libpugixml-dev -y
  cmake -DCMAKE_INSTALL_PREFIX=/usr -B build
  cmake --build build -j `nproc`
  sudo cmake --install build
  popd
}

build-sdbus-cpp() {
  clone-or-pull https://github.com/Kistler-Group/sdbus-cpp.git sdbus-cpp $SDBUS_CPP_VERSION
  git checkout v1.6.0
  mkdir build
  cd build
  cmake .. -DCMAKE_BUILD_TYPE=Release
  make
  sudo make install
  popd
}

build-aquamarine() {
  sudo nala install -y libdisplay-info-dev libgbm-dev
  build-libinput
  clone-or-pull https://github.com/hyprwm/aquamarine.git aquamarine $AQUAMARINE_VERSION
  cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build
  cmake --build ./build --config Release --target all -j`nproc 2>/dev/null || getconf _NPROCESSORS_CONF`
  sudo cmake --install ./build
  popd
}

build-libinput() {
  sudo nala install -y build-essential libgtk-3-dev check
  clone-or-pull https://gitlab.freedesktop.org/libinput/libinput libinput $LIBINPUT_VERSION
  meson setup --prefix=/usr builddir/
  ninja -C builddir/
  sudo ninja -C builddir/ install
  popd
}

build-libxcb-errors() {
  sudo nala install -y dh-autoreconf xutils-dev xcb-proto
  clone-or-pull https://gitlab.freedesktop.org/xorg/lib/libxcb-errors.git libxcb-errors $LIBXCB_ERROR_VERSION
  ./autogen.sh --prefix=/usr
  sudo make install
  popd
}

install-cmake() {
  wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | gpg --dearmor - | sudo tee /usr/share/keyrings/kitware-archive-keyring.gpg >/dev/null
  echo 'deb [signed-by=/usr/share/keyrings/kitware-archive-keyring.gpg] https://apt.kitware.com/ubuntu/ noble main' | sudo tee /etc/apt/sources.list.d/kitware.list >/dev/null
  sudo nala update
  sudo nala install cmake -y
}

build-deps () {
  sudo apt-get install -y nala
  sudo nala install -y meson wget ninja-build  \
     gettext gettext-base fontconfig libfontconfig-dev libffi-dev libxml2-dev \
    libdrm-dev libxkbcommon-x11-dev libxkbregistry-dev libxkbcommon-dev libpixman-1-dev \
    libudev-dev libseat-dev seatd libxcb-dri3-dev libegl-dev libgles2 libegl1-mesa-dev \
    glslang-tools libinput-bin libinput-dev libxcb-composite0-dev libavutil-dev \
    libavcodec-dev libavformat-dev libxcb-ewmh2 libxcb-ewmh-dev libxcb-present-dev \
    libxcb-icccm4-dev libxcb-render-util0-dev libxcb-res0-dev libxcb-xinput-dev \
    xdg-desktop-portal-wlr libtomlplusplus3 g++-14 gcc-14 libmagic-dev libsdbus-c++-dev \
    libpam0g-dev qt6-base-dev
# build-essential cmake cmake-extras

if confirm "Do you want to build tomlplusplus?"; then
  echo "------------ tomlplusplus ---------------"
  build-tomlpp
fi

if confirm "Do you want to build wayland?"; then
  echo "------------ wayland ---------------"
  build-wayland
fi

if confirm "Do you want to build wayland-protocols?"; then
  echo "------------ wayland-protocols ---------------"
  build-wayland-protocols
fi

if confirm "Do you want to build hyprland-protocols"; then
  echo "------------ hyprland-protocols ---------------"
  build-hyprland-protocols
fi

if confirm "Do you want to build hyprutils"; then
  echo "------------ hyprutils ---------------"
  build-hyprutils
fi

if confirm "Do you want to build hyprwayland-scanner"; then
  echo "------------ hyprwaylandiscanner ---------------"
  build-hyprwayland-scanner
fi

if confirm "Do you want to build aquamarine"; then
  echo "------------ aquamarine ---------------"
  build-aquamarine
fi

if confirm "Do you want to build libxcb-errors"; then
  echo "------------ libxcb-errors ---------------"
  build-libxcb-errors
fi

if confirm "Do you want to build cmake"; then
  echo "------------ cmake >= 3.30 ---------------"
  install-cmake
fi

echo "------------ deps done ---------------"
}

build-hyprland () {
  sudo nala install -y libxcb-util-dev
  clone-or-pull https://github.com/hyprwm/Hyprland hyprland $HYPRLAND_VERSION
  make all && sudo make install
  popd
}

build-hyprlang() {
  clone-or-pull https://github.com/hyprwm/hyprlang.git hyprlang $HYPRLANG_VERSION
  cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build
  cmake --build ./build --config Release --target hyprlang -j`nproc 2>/dev/null || getconf NPROCESSORS_CONF`
  sudo cmake --install ./build
  popd
}

build-hyprpaper() {
  clone-or-pull https://github.com/hyprwm/hyprpaper hyprpaper $HYPRPAPER_VERSION
  cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build
  cmake --build ./build --config Release --target hyprpaper -j`nproc 2>/dev/null || getconf NPROCESSORS_CONF`
  sudo cmake --install ./build
  popd
}

build-hypridle() {
  clone-or-pull https://github.com/hyprwm/hypridle.git hypridle $HYPRIDLE_VERSION
  cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -S . -B ./build
  cmake --build ./build --config Release --target hypridle -j`nproc 2>/dev/null || getconf NPROCESSORS_CONF`
  sudo cmake --install build
  popd
}

build-xdg-desktop-portal-hyprland() {
  sudo nala install -y qt6-wayland libspa-0.2-dev
  clone-or-pull https://github.com/hyprwm/xdg-desktop-portal-hyprland.git xdg-desktop-portal-hyprland $XDG_DESKTOP_PORTAL_HYPRLAND_VERSION
  cmake -DCMAKE_INSTALL_LIBEXECDIR=/usr/lib -DCMAKE_INSTALL_PREFIX=/usr -B build
  cmake --build build
  sudo cmake --install build
  popd
}

build-hyprlock() {
  clone-or-pull https://github.com/hyprwm/hyprlock.git hyprlock $HYPRLOCK_VERSION
  cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -S . -B ./build
  cmake --build ./build --config Release --target hyprlock -j`nproc 2>/dev/null || getconf NPROCESSORS_CONF`
  sudo cmake --install build
  popd
}

build-hyprpicker() {
  clone-or-pull https://github.com/hyprwm/hyprpicker hyprpicker $HYPRPICKER_VERSION
  cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build
  cmake --build ./build --config Release --target hyprpicker -j`nproc 2>/dev/null || getconf NPROCESSORS_CONF`
  sudo cmake --install ./build
  popd
}

build-hyprcursor() {
  sudo nala install -y libzip-dev librsvg2-dev
  clone-or-pull https://github.com/hyprwm/hyprcursor hyprcursor $HYPRCURSOR_VERSION

  cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build
  cmake --build ./build --config Release --target all -j`nproc 2>/dev/null || getconf NPROCESSORS_CONF`
  sudo cmake --install build
  popd
}

build-satty() {
  clone-or-pull https://github.com/gabm/Satty satty $SATTY_VERSION
  sudo nala install libepoxy-dev librust-gdk4-sys-dev libadwaita-1-dev slurp
  make build-release
  sudo PREFIX=/usr/local make install
  popd
}

export CXX=/usr/bin/g++-14
export CXXFLAGS=-std=gnu++26
export CC=/usr/bin/gcc-14

if [ ! -d ~/git/hyprSource ]; then
  mkdir ~/git/hyprSource
fi
cd ~/git/hyprSource

if confirm "Do you want to install dependencies?"; then
  build-deps
fi
if confirm "Do you want to build Hyprlang?"; then
  build-hyprlang
fi
if confirm "Do you want to build Hyprcursor?"; then
  build-hyprcursor
fi
if confirm "Do you want to build Hyprland?"; then
  build-hyprland
fi
if confirm "Do you want to build Hyprpaper?"; then
  build-hyprpaper
fi
if confirm "Do you want to build Hypridle?"; then
  build-hypridle
fi
if confirm "Do you want to build Hyprlock?"; then
  build-hyprlock
fi
if confirm "Do you want to build Hyprpicker?"; then
  build-hyprpicker
fi
if confirm "Do you want to build xdg-desktop-portal-hyprland?"; then
  build-xdg-desktop-portal-hyprland
fi

if confirm "Do you want to install wlogout?"; then
  sudo nala install wlogout -y
fi
if confirm "Do you want to build Satty?"; then
  build-satty
fi
