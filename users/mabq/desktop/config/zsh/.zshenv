# vim: filetype=sh

# Important!
# Be careful what you put here as it affects every zsh invocation (including scp, rsync, etc).
# This file is read right after `/etc/zshenv`, which NixOS automatically configures to source `/etc/zshenv.local` which is where we set $NIXOS_USERPROFILEPATH.

# Do not to read other global zsh config files (like `/etc/zshrc`). We don't need those configurations are they conflict with ours.
setopt NO_GLOBAL_RCS

# Source all files directly from the repository.
ZDOTDIR="$NIXOS_USERPROFILEPATH/config/zsh"
