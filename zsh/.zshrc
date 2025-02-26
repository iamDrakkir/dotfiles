#!/bin/sh
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"

zle_highlight=('paste:none')

# local sources
plug "$HOME/.config/zsh/aliases.zsh"
plug "$HOME/.config/zsh/exports.zsh"
plug "$HOME/.config/zsh/completions.zsh"

# Plugins
plug "zap-zsh/supercharge"
plug "zap-zsh/fzf"
plug "zsh-users/zsh-autosuggestions"
plug "Aloxaf/fzf-tab"
plug "zdharma-continuum/fast-syntax-highlighting"
plug "zap-zsh/vim"

# Edit line in nvim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# Check if Starship is installed
if command -v starship >/dev/null 2>&1; then
    eval "$(starship init zsh)"
else
    plug "$HOME/.config/zsh/prompt.zsh"
fi

