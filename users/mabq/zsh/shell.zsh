# History
# Do not export these, otherwise other shells (bash) will try to use same HISTFILE.
HISTFILE=${HOME}/.local/share/zsh/zsh_history # put file away from home
[[ -d ${HISTFILE:h} ]] || mkdir -p ${HISTFILE:h} # ensure the directory exists
SAVEHIST=10000 # lines to save to history file
HISTSIZE="${SAVEHIST}" # lines to keep in memory

# Autocompletion
# NixOS automatically generates the `/etc/zshenv` file, there it instructs zsh how to find installed completions.
autoload -Uz compinit # prepare to load compinit, don't use aliases and use zsh-style zstyle ":completion:*" menu select # use select completion style
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # make completion case-insensitive
ZCOMPFILE=${HOME}/.cache/zsh/zcompdump-${ZSH_VERSION} # put file away from home
[[ -d ${ZCOMPFILE:h} ]] || mkdir -p ${ZCOMPFILE:h} # ensure the directory exists
compinit -d "$ZCOMPFILE" # initialize the completion module

# Zsh plugins
# These packages do not provide executables, you must source them from NixOS paths.
if [[ -f $NIXOS_CURRENT_HOME/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
  source $NIXOS_CURRENT_HOME/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi
if [[ -f $NIXOS_CURRENT_HOME/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
  source $NIXOS_CURRENT_HOME/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi
if [[ -f $NIXOS_CURRENT_HOME/share/zsh-history-substring-search/zsh-history-substring-search.zsh ]]; then
  source $NIXOS_CURRENT_HOME/share/zsh-history-substring-search/zsh-history-substring-search.zsh
  bindkey '^[[A' history-substring-search-up # up arrow
  bindkey '^[[B' history-substring-search-down # donw arrow
  HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND=''
  HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND=''
fi

# TODO: Ensure command hashing is off for mise
set +h
