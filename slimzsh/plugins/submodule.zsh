# initialize a submodule if required

t0=$(perl -MTime::HiRes -e 'printf("%.0f\n",Time::HiRes::time()*1000)')

# check if submodules need initing
# this is too slow

# only check submodules if any seem empty
# if ls -ld $slim_path/submod/*(^F).*(N) &>/dev/null; then
#     echo "need to init"
#     :
# else
#     echo "nothing to do"
# fi


submods=($slim_path/submod/*)

for submod in $submods; do
    files=($submod/*(N))
    if [ ${#files[@]} -gt 0 ]; then
        :
    else
        echo "need to init"
    fi
    unset submod
done

unset submods



# FIX HOW WE INIT TO ACCOUNT FOR ^^ RESULTS

# THIS COMMAND IS REALLY TOO SLOW
# submodstats=$(cd ${__dotfiles_absdir} && git submodule status --recursive)


# ta=$(perl -MTime::HiRes -e 'printf("%.0f\n",Time::HiRes::time()*1000)')
# echo "PLUGIN submod submodstat: $(( ta-t0 ))"

# for submodstat in $submodstats; do
#     if [[ ${submodstat:0:1} = \- ]] ; then
#         echo
#         echo "Initializing and updating submodules ..."
#         echo
#         # run in a subshell
#         # TODO: there is probably a better way, but this works
#         /bin/bash -c "cd ${__dotfiles_absdir} && git submodule update --init --recursive"
#         break
#     fi
# done

# load submods
source $slim_path/submod/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $slim_path/submod/zsh-history-substring-search/zsh-history-substring-search.zsh

t1=$(perl -MTime::HiRes -e 'printf("%.0f\n",Time::HiRes::time()*1000)')
echo "PLUGIN submod: $(( t1-t0 ))"