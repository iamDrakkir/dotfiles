#!/bin/bash
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

pushd ~/.dotfiles/install_scripts/
if confirm "Do you want to run stow?"; then
  source stow.sh
fi

if confirm "Do you want to install base packages?"; then
  source base_packages.sh
fi

if confirm "Do you want to install gaming package?"; then
  source gaming_packages.sh
fi

if confirm "Do you want to change default shell to zsh and install zap?"; then
  source zsh.sh
fi

if confirm "Do you want to install Nerd Font?"; then
  source fonts.sh
fi

if confirm "Do you want to install Neovim?"; then
  source neovim.sh
fi

if confirm "Do you want to install 1pass?"; then
  source 1pass.sh
fi

if confirm "Do you want to add ssh key from 1pass?"; then
  source ssh_key.sh
fi

if confirm "Do you want to install Hyprland?"; then
  source hyprland.sh
fi

if confirm "Do you want to install rofi-wayland?"; then
  source rofi_wayland.sh
fi

if confirm "Do you want to install waybar?"; then
  source waybar.sh
fi

if confirm "Do you want to install swaync?"; then
  source swaync.sh
fi
popd

pushd ~/.dotfiles/
if confirm "Do you want dotfiles to use ssh key?"; then
  git remote set-url origin git@github.com:iamDrakkir/dotfiles.git
fi
popd
