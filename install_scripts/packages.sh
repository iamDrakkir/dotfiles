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

install_paru() {
  git clone https://aur.archlinux.org/paru.git ~/paru
  cd ~/paru || exit 1
  makepkg -si
}

intall_paru_packages() {
  paru -S --noconfirm "${paru_packages[@]}"
}

install_zsh_zap() {
    wget -O /tmp/install.sh https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh
    zsh /tmp/install.sh
}

# Function to create zsh history file
create_history_file() {
    touch "$HOME/.zsh_history"
    chmod 644 "$HOME/.zsh_history"
}

# Function to change shell to ZSH
change_shell_to_zsh() {
    chsh -s "$(command -v zsh)" "$USER"
}

# Function to remove Neovim
remove_neovim() {
    rm -rf "$HOME/git/neovim"
}

# Function to clone Neovim
clone_neovim() {
    git clone --depth 1 --branch nightly https://github.com/neovim/neovim.git "$HOME/git/neovim"
}

# Function to build Neovim
build_neovim() {
    cd "$HOME/git/neovim" || exit 1
    make -j 20
}

# Function to install Neovim
install_neovim() {
    sudo make install -C "$HOME/git/neovim"
}

# Function to install Vim plugins
install_vim_plugins() {
    nvim --headless "+Lazy! sync" +qa
}

add_private_ssh_key() {
  # Check if the user is signed in to 1Password
  if ! op whoami >/dev/null 2>&1; then
    echo "User is not signed in to 1Password."
    # Sign in to 1Password
    eval $(op signin)
    if [ $? -ne 0 ]; then
      echo "Failed to sign in to 1Password."
      return 1
    fi
  fi

  # Add 1Password account if not already added
  if ! op account list | grep -q "my"; then
    op account add
  fi

  # Retrieve private key and save it to file
  op read "op://private/github ssh key/private key" > ~/.ssh/github_private_key
  if [ $? -ne 0 ]; then
    echo "Failed to retrieve the private key."
    return 1
  fi

  # Set appropriate permissions on the private key file
  chmod 600 ~/.ssh/github_private_key

  # Add the private key to SSH agent
  ssh-add ~/.ssh/github_private_key
  if [ $? -ne 0 ]; then
    echo "Failed to add the private key to SSH agent."
    return 1
  fi

  echo "Private SSH key added successfully."
}

install_nerd_font() {
  wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/FiraMono.zip
  unzip FiraMono.zip -d FiraMono
  rm FiraMono.zip
  sudo mv FiraMono /usr/share/fonts/

  wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.zip
  unzip JetBrainsMono.zip -d JetBrainsMono
  rm JetBrainsMono.zip
  sudo mv JetBrainsMono /usr/share/fonts/

  sudo fc-cache -fv
}

# Main function
main() {
    packages=(
      nala
      firefox
      zsh
      stow
      cmake
      pkgconf
      unzip
      gettext
      alacritty
      foot
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
      wl-clipboard
      cliphist
      pavucontrol
      grim
      fonts-noto
      fonts-font-awesome
      dunst
      lactd
      mangohud
    )
    if confirm "Do you want to install packages?"; then
      install_system_packages
    fi
    # todo: rustup and rustup default stable
    # todo: gettext, make, cmake is deps for neovim
    # todo: fix fd-find symlink
    # steam
    # discord
    if confirm "Do you want to install Nerd Font?"; then
      source fonts.sh
    fi

    if confirm "Do you want to install Zsh and setup Zap?"; then
      source zsh_zap.sh
    fi

    if confirm "Do you want to install Neovim?"; then
      source neovim.sh
    fi

    if confirm "Do you want to install 1pass?"; then
      source 1pass.sh
    fi

    # disable super+p default behaviour
    # settings set org.gnome.mutter.keybindings switch-monitor "['XF86Display']"
}

main "$@"
