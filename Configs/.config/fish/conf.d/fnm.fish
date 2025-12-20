#!/usr/bin/env fish

# fnm (Fast Node Manager) shell integration
# Only loads if fnm is installed

if type -q fnm
    fnm env --use-on-cd --shell fish | source
end
