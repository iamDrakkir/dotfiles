#!/bin/bash

# Function to install system packages
install_system_packages() {
    distribution=$(awk -F= '/^NAME/{print $2}' /etc/os-release)
    case $distribution in
        *"Debian"* | *"Ubuntu"*)
            sudo apt-get update
            sudo apt-get install -y "${packages[@]}"
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
    rm -rf "$HOME/neovim"
}

# Function to clone Neovim
clone_neovim() {
    git clone --depth 1 --branch nightly https://github.com/neovim/neovim.git "$HOME/neovim"
}

# Function to build Neovim
build_neovim() {
    cd "$HOME/neovim" || exit 1
    make -j 20
}

# Function to install Neovim
install_neovim() {
    sudo make install -C "$HOME/neovim"
}

# Function to install Vim plugins
install_vim_plugins() {
    nvim --headless "+Lazy! sync" +qa
}

add_private_ssh_key() {
  # Retrieve private key and save it to file
  op read "op://private/github ssh key/private key" > ~/.ssh/github_private_key

  # Set appropriate permissions on the private key file
  chmod 600 ~/.ssh/github_private_key

  # Add the private key to SSH agent
  ssh-add ~/.ssh/github_private_key
}

# Main function
main() {
    packages=(
      zsh
      stow
      base-devel
      cmake
      pkgconf
      lua
      unzip
      libtool
      gettext
      alacritty
      tmux
      ripgrep
      exa
      bat
      fzf
      zoxide
      entr
      fd
      python
      python-pip
    )
    install_paru
    paru_packages=(
      1password
      1password-cli
      swww
      pywal
    )
    install_system_packages

    #zsh
    install_zsh
    install_zsh_zap
    create_history_file
    change_shell_to_zsh

    #neovim
    remove_neovim
    clone_neovim
    build_neovim
    install_neovim
    install_vim_plugins

    #ssh
    add_private_ssh_key

    #change checkout from https to ssh
    git remote set-url origin git@github.com:iamDrakkir/dotfiles.git
}

main "$@"
