# History control - don't export these, otherwise other shells (bash) will try to use same HISTFILE.
HISTFILE=$HOME/.local/share/zsh/zsh_history
[[ -d ${HISTFILE:h} ]] || mkdir -p ${HISTFILE:h} # ensure the directory exists
SAVEHIST=10000 # lines to save to history file
HISTSIZE="${SAVEHIST}" # lines to keep in memory
