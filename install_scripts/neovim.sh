#!/bin/bash
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

build_neovim() {
    make CMAKE_BUILD_TYPE=Release
    sudo make install
}

install_neovim() {
    sudo make install -C "$HOME/git/neovim"
    popd
}

install_vim_plugins() {
    nvim --headless "+Lazy! sync" +qa
}

install_deps() {
    sudo apt install cmake gettext
}


install_deps
clone-or-pull https://github.com/neovim/neovim.git "$HOME/git/neovim" stable
build_neovim
install_neovim
