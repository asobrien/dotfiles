# initialize a submodule if required

# check if submodules need initing
submodstats=`git -C ${__dotfiles_absdir} submodule status --recursive`

for submodstat in $submodstats; do
    if [[ ${submodstat:0:1} = \- ]] ; then
        echo "Initializing and updating submodules ..."
        echo
        git submodule update --init --recursive
        break
    fi
done

# load submods
source $slim_path/submod/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $slim_path/submod/zsh-history-substring-search/zsh-history-substring-search.zsh