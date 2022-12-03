#!/bin/sh

export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
HISTSIZE=100000
SAVEHIST=100000

# Man pages
export MANPAGER='nvim +Man!'
export MANWIDTH=999

# Editor
export EDITOR='nvim'
export VISUAL=nvim

# FZF
export FZF_DEFAULT_COMMAND='rg --hidden -l ""'
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'

export BAT_THEME='gruvbox-dark'

# Load zoxide 
eval "$(zoxide init zsh)"
