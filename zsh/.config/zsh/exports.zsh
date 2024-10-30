#!/bin/sh

export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state
HISTSIZE=100000
SAVEHIST=100000

PATH=$HOME/.local/bin:/lib/security:$PATH

# Man pages
export MANPAGER='nvim +Man!'
export MANWIDTH=999

# Editor
export EDITOR='nvim'
export VISUAL=nvim

# FZF
export FZF_DEFAULT_COMMAND='rg --hidden -l ""'
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border --ansi'

# export BAT_THEME='gruvbox-dark'

# Load zoxide
eval "$(zoxide init zsh)"

if [ -d $HOME/.config/nvm ]; then
  export NVM_DIR="$HOME/.config/nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi
