#!/bin/sh

export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state
HISTSIZE=100000
SAVEHIST=100000

PATH=$HOME/.local/bin:$PATH

# Man pages
export MANPAGER='nvim +Man!'
export MANWIDTH=999

# Editor
export EDITOR='nvim'
export VISUAL=nvim

# FZF
export FZF_DEFAULT_COMMAND='rg --hidden -l ""'
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
# FZF rosepine
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS"
 --color=fg:#e0def4,bg:#1f1d2e,hl:#6e6a86
 --color=fg+:#908caa,bg+:#191724,hl+:#908caa
 --color=info:#9ccfd8,prompt:#f6c177,pointer:#c4a7e7
 --color=marker:#ebbcba,spinner:#eb6f92,header:#ebbcba"

export BAT_THEME='gruvbox-dark'

# export MANGOHUD=1

# Load zoxide
eval "$(zoxide init zsh)"
