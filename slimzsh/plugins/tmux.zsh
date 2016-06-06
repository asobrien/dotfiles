# Show TMUX sessions, if any

if (( $+commands[tmux] )); then
    if tmux info &> /dev/null; then
        echo
        echo "Active tmux sessions ..."
        tmux list-sessions
        echo
    else
        return
    fi
fi

