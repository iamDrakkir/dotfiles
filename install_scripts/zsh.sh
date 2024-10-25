create_history_file() {
    if [ ! -f $HOME/.zsh_history ]; then
      touch "$HOME/.zsh_history"
      chmod 644 "$HOME/.zsh_history"
    fi
}

change_shell_to_zsh() {
    chsh -s "$(command -v zsh)" "$USER"
}

install_zap() {
  zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --branch release-v1
}

install_starship() {
  curl -sS https://starship.rs/install.sh | sh
}

create_history_file
change_shell_to_zsh
install_zap
install_starship
