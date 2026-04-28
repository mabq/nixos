# History - don't export these, otherwise other shells (bash) will try to use same HISTFILE.
HISTFILE=$HOME/.local/share/zsh/zsh_history
[[ -d ${HISTFILE:h} ]] || mkdir -p ${HISTFILE:h} # ensure the directory exists
SAVEHIST=10000 # lines to save to history file
HISTSIZE="${SAVEHIST}" # lines to keep in memory

# Autocompletion
# TODO: move the file out o the repo
# NixOS automatically generates the `/etc/zshenv` file, there it tells zsh how to find installed completions.
autoload -Uz compinit # prepare to load compinit, don't use aliases and use zsh-style
zstyle ":completion:*" menu select # use select completion style
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # make completion case-insensitive
ZCOMPFILE=${HOME}/.cache/zsh/zcompdump-${ZSH_VERSION} # file location
[[ -d ${ZCOMPFILE:h} ]] || mkdir -p ${ZCOMPFILE:h} # ensure the directory exists
compinit -d "$ZCOMPFILE" # initialize the completion module

# Source Nix plugins
# TODO: Check if the path is secure
load_plugins() {
  local path=$HOME/.local/state/home-manager/gcroots/current-home/home-path/share

  if [[ -f $path/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
    source $path/zsh-autosuggestions/zsh-autosuggestions.zsh
  fi

  if [[ -f $path/zsh-history-substring-search/zsh-history-substring-search.zsh ]]; then
    source $path/zsh-history-substring-search/zsh-history-substring-search.zsh
    bindkey '^[[A' history-substring-search-up # up arrow
    bindkey '^[[B' history-substring-search-down # donw arrow
    HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND=''
    HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND=''
  fi

  if [[ -f $path/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
    source $path/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
  fi
}
load_plugins

# Ensure command hashing is off for mise
set +h
