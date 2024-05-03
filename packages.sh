#!/bin/bash

# Function to install system packages
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
    rm -rf "$HOME/neovim"
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
  #todo: add check if user exist
  #todo check if user is signin
  op account add
  eval $(op signin)
  # Retrieve private key and save it to file
  op read "op://private/github ssh key/private key" > ~/.ssh/github_private_key

  # Set appropriate permissions on the private key file
  chmod 600 ~/.ssh/github_private_key

  # Add the private key to SSH agent
  ssh-add ~/.ssh/github_private_key
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
      steam
      discord
      vlc
      bibata-cursor-theme
      wl-clipboard
      #breeze-icon-theme maybe?
      fonts-noto
      fonts-font-awesome
      dunst
      #base-devel
      #lua
      #libtool
    )
    # todo: gettext is deps for neovim
    # todo: fix fd-find symlink
    #install_paru
    #paru_packages=(
    #  1password
    #  1password-cli
    #  swww
    #  pywal
    #)
    #install_system_packages
    pipx install pywal
    install_nerd_font


    #zsh
    #install_zsh
    #install_zsh_zap
    #create_history_file
    #change_shell_to_zsh

    #neovim
    #remove_neovim
    #clone_neovim
    #build_neovim
    #install_neovim
    #install_vim_plugins #todo: stow is not done at this point, so lazy does not exist.

    #ssh
    # add_private_ssh_key

    #change checkout from https to ssh
    # git remote set-url origin git@github.com:iamDrakkir/dotfiles.git

    # enable super+p
    # settings set org.gnome.mutter.keybindings switch-monitor "['XF86Display']"
}

main "$@"
