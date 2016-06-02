# initialize a submodule if required

# check if submodules need initing
submodstats=$(cd ${__dotfiles_absdir} && git submodule status --recursive)

for submodstat in $submodstats; do
    if [[ ${submodstat:0:1} = \- ]] ; then
        echo
        echo "Initializing and updating submodules ..."
        echo
        # run in a subshell
        /bin/bash -c "cd ${__dotfiles_absdir} && git submodule update --init --recursive"
        break
    fi
done

# load submods
source $slim_path/submod/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $slim_path/submod/zsh-history-substring-search/zsh-history-substring-search.zsh