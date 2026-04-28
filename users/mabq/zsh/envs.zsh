# Environment variables
# Do not set the `TERM` variable!, it is set by each terminal emulator.
export EDITOR="nvim" # TODO: move this later to uswm
export SUDO_EDITOR="$EDITOR"
export BAT_THEME=ansi
# export BROWSER="brave"  # when opening links
# export GPG_TTY="${TTY:-$(tty)}"
# export GTK_THEME="Adwaita:dark"
# export MANPAGER="less -R --use-color -Dd+r -Du+b"
# export MANROFFOPT="-P -c"  # https://wiki.archlinux.org/title/Color_output_in_console#Using_less
# export PAGER="less -R --use-color -Dd+r -Du+b"
# export VISUAL="nvim"  # when opening a GUI editor (nnn `-e` option will respect this variable)
# export VOLTA_HOME="$XDG_CONFIG_HOME/.volta" # The hassle-free JavaScript Tools Manager

# Duplicated from .config/uwsm/env so SSH works too
export NIXOS_CONFIG_PATH=$HOME/.local/share/nixos-config
export PATH=$NIXOS_CONFIG_PATH/bin:$PATH:$HOME/.local/bin

# SSH Agent
# Required for the ssh-agent to work across terminals
# export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"  # https://wiki.archlinux.org/title/SSH_keys#Start_ssh-agent_with_systemd_user
