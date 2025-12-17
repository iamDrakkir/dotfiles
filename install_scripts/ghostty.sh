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

build_ghostty() {
  echo "build"
  zig build -p $HOME/.local -Doptimize=ReleaseFast
  echo "done"
}

install_ghostty() {
  ln -s zig-out/bin/ghostty $HOME/.local/bin/ghostty
  ln -s zig-out/share/bash-completion/completions/ghostty.bash $HOME/.local/share/bash-completion/completions/ghostty.bash}
  ln -s zig-out/share/applications/com.mitchellh.ghostty.desktop $HOME/.local/applications/com.mitchellh.ghostty.desktop
}

install_deps() {
  sudo apt install libgtk-4-dev libadwaita-1-dev
  sudo snap install zig --classic --beta
}


install_deps
clone-or-pull https://github.com/ghostty-org/ghostty.git "$HOME/git/ghostty" v1.1.2
build_ghostty
# install_ghostty
popd
