#!/bin/bash

install_system_packages() {
  distribution=$(awk -F= '/^NAME/{print $2}' /etc/os-release)
  case $distribution in
     *"Debian"* | *"Ubuntu"*)
        sudo apt-get update
        sudo apt-get install -y nala
        sudo nala install -y "${packages[@]}"
        ;;
     *"Arch"*)
        sudo pacman -Syu --noconfirm "${packages[@]}"
        ;;
     *)
        echo "Unsupported distribution: $distribution"
        exit 1
        ;;
  esac
}


packages=(
  mangohud
  corectrl
)

install_system_packages
