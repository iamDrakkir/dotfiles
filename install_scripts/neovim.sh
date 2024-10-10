#!/bin/bash
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


remove_neovim
clone_neovim
build_neovim
install_neovim
install_vim_plugins #todo: stow is not done at this point, so lazy does not exist.
