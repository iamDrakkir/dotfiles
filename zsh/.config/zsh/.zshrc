#!/bin/sh

# Some useful options (man zshoptions)
setopt autoCd extendedGlob noMatch menuComplete
setopt extendedHistory incAppendHistoryTime
setopt interactiveComments
stty stop undef		# Disable ctrl-s to freeze terminal.
zle_highlight=('paste:none')

# Beeping is annoying
unsetopt BEEP

# Colors
autoload -Uz colors && colors

# Useful Functions
source "$ZDOTDIR/zsh-functions"

# Normal files to source
zsh_add_file "zsh-exports"
zsh_add_file "zsh-aliases"
#zsh_add_file "zsh-vim-mode"
zsh_add_file "zsh-completion"
zsh_add_file "zsh-prompt"

# Plugins
zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "zdharma-continuum/fast-syntax-highlighting"
zsh_add_plugin "iamDrakkir/zsh-you-should-use"
# For more plugins: https://github.com/unixorn/awesome-zsh-plugins
# More completions https://github.com/zsh-users/zsh-completions

# Load zoxide 
eval "$(zoxide init zsh)"

# Key-bindings
bindkey -s '^n' 'nvim\n'

# FZF
source /usr/share/doc/fzf/examples/key-bindings.zsh
source /usr/share/doc/fzf/examples/completion.zsh
export FZF_DEFAULT_COMMAND='rg --hidden -l ""'
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'

# Edit line in nvim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line
