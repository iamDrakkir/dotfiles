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
symlink_fd() {
  if [ ! -d ~/.local/bin ]; then
    mkdir ~/.local/bin
  fi
  ln -s $(which fdfind) ~/.local/bin/fd
}


packages=(
  firefox
  zsh
  stow
  cmake
  unzip
  alacritty
  foot
  kitty
  tmux
  ripgrep
  eza
  bat
  fzf
  zoxide
  entr
  fd-find
  python3
  python3-pip
  pipx
  curl
  vlc
  bibata-cursor-theme
  fonts-inter-variable
  pavucontrol
  wl-clipboard
  cliphist
  grim
)

symlink_fd

install_system_packages
