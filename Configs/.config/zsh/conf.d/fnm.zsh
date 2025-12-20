#!/usr/bin/env zsh

# fnm (Fast Node Manager) shell integration
# Only loads if fnm is installed

if command -v fnm &>/dev/null; then
    eval "$(fnm env --use-on-cd --shell zsh)"
fi
