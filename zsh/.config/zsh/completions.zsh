
if [ -f /etc/bash_completion.d/azure-cli ]; then
    source /etc/bash_completion.d/azure-cli
fi

# bun completions
[ -s "/home/drakkir/.bun/_bun" ] && source "/home/drakkir/.bun/_bun"


eval "$(uv generate-shell-completion zsh)"
