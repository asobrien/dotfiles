# setup alias, as required
if (( $+commands[thefuck] )); then
    eval "$(thefuck --alias)"
fi
