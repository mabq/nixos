# Use vi mode instead of emacs (default)
bindkey -v
# Zsh bug fix (https://github.com/spaceship-prompt/spaceship-prompt/issues/91#issuecomment-327996599)
bindkey '^?' backward-delete-char

# Bind Ctrl+Left and Ctrl+Right to move by words
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word

# Control + Backspace to delete a word backward
bindkey '^H' backward-kill-word # common sequence for Ctrl+Backspace
bindkey '^[[3;5~' backward-kill-word # alternative sequence used by some terminals

# Launch tmux-sessionizer with Ctrl-/
# bindkey -s '^s' "$HOME/.config/tmux/scripts/tmux-sessionizer.sh\n"
#bindkey -s '^_' "$HOME/.config/zellij/scripts/zellij-sessioniner.sh\n"

# History search up/down arrows (requires zsh-history-substring-search plugin)
# (disabled because now we are using atuin)




# Stolen from ArchWiki

# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -A key

key[Home]=${terminfo[khome]}

key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}

# setup key accordingly
[[ -n "${key[Home]}"     ]]  && bindkey  "${key[Home]}"     beginning-of-line
[[ -n "${key[End]}"      ]]  && bindkey  "${key[End]}"      end-of-line
[[ -n "${key[Insert]}"   ]]  && bindkey  "${key[Insert]}"   overwrite-mode
[[ -n "${key[Delete]}"   ]]  && bindkey  "${key[Delete]}"   delete-char
[[ -n "${key[Up]}"       ]]  && bindkey  "${key[Up]}"       up-line-or-history
[[ -n "${key[Down]}"     ]]  && bindkey  "${key[Down]}"     down-line-or-history
[[ -n "${key[Left]}"     ]]  && bindkey  "${key[Left]}"     backward-char
[[ -n "${key[Right]}"    ]]  && bindkey  "${key[Right]}"    forward-char
[[ -n "${key[PageUp]}"   ]]  && bindkey  "${key[PageUp]}"   beginning-of-buffer-or-history
[[ -n "${key[PageDown]}" ]]  && bindkey  "${key[PageDown]}" end-of-buffer-or-history

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
    function zle-line-init () {
        printf '%s' "${terminfo[smkx]}"
    }
    function zle-line-finish () {
        printf '%s' "${terminfo[rmkx]}"
    }
    zle -N zle-line-init
    zle -N zle-line-finish
fi
