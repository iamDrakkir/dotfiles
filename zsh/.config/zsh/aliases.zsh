#!/bin/sh
# Confirm before overwriting something
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'

# quick history
alias h="history"

# Easier to read disk
alias df='df -h'       # human-readable sizes
alias free='free -m'   # show sizes in MB

# Neovim
alias vim='nvim'
alias vi='nvim'
alias v='nvim'

# Folders
alias dot='$HOME/.dotfiles'

# Quick cd
alias cdd='cd $HOME/.dotfiles'
alias cdn='cd $HOME/.dotfiles/nvim/.config/nvim'

# Oxidize
alias ls='exa --grid --color auto --icons --sort=type'
alias ll='exa --long --color always --icons --sort=type'
alias la='exa --grid --all --color auto --icons --sort=type'
alias lla='exa --long --all --color auto --icons --sort=type'
alias tree='exa --tree'
alias cat='batcat'
alias grep='rg'

# Git aliases
alias gs='git status'
alias ga='git add'
alias gp='git push'
alias gpo='git push origin'
alias gtd='git tag --delete'
alias gtdr='git tag --delete origin'
alias gr='git branch -r'
alias gplo='git pull origin'
alias gb='git branch '
alias gc='git commit'
alias gd='git diff'
alias gco='git checkout '
alias gl='git log'
alias gr='git remote'
alias grs='git remote show'
alias glo='git log --pretty="oneline"'
alias glol='git log --graph --oneline --decorate'

# Zellij
alias zz='zellij a $(zellij list-sessions | fzf)'
