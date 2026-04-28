# History control.
#   Don't export these, otherwise other shells (bash) will try to use same HISTFILE.
HISTFILE=$HOME/.local/share/zsh/zsh_history
[[ -d ${HISTFILE:h} ]] || mkdir -p ${HISTFILE:h} # Ensure the directory exists.
SAVEHIST=10000 # Lines to save to history file.
HISTSIZE="${SAVEHIST}" # Lines to keep in memory.

# Autocompletion.
# fpath is set in `/etc/.zshenv` by NixOS.
autoload -Uz compinit
zstyle ":completion:*" menu select # Completion styling (optional but recommended).
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # Case-insensitive.
compinit # Initialize the completion module.

# Source Nix plugins


# Ensure command hashing is off for mise
set +h
