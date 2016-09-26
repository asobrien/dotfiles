# path vars
slim_path=`dirname $0`
__slimzsh_absdir=`dirname $0:A`
__dotfiles_absdir=${__slimzsh_absdir%/*}

fpath=(/usr/local/share/zsh-completions $slim_path $fpath)

autoload -U promptinit && promptinit
prompt pure

autoload -U compinit
compinit -u

setopt autocd
setopt extendedglob

export CLICOLOR=1

# CORE COMPONENTS
source $slim_path/keys.zsh
source $slim_path/completion.zsh
source $slim_path/aliases.zsh
source $slim_path/stack.zsh

# UNUSED
# source $slim_path/history.zsh  # we use it via a plugin
# source $slim_path/correction.zsh  # more annoying than not

# What do I do?
if command -v fasd >/dev/null 2>&1; then
  eval "$(fasd --init zsh-hook zsh-ccomp zsh-ccomp-install zsh-wcomp zsh-wcomp-install posix-alias)"
fi


# load all plugins
for plugin_file ($slim_path/plugins/*); do
  source $plugin_file
  unset plugin_file
done


# load all private files
if [[ -d "$slim_path/private" ]]; then
    for plugin_file ($slim_path/private/*); do
        source $plugin_file
        unset plugin_file
    done
fi


export PATH=$PATH:${slim_path}/bin

# HOST SPECIFIC SETTINGS
if [[ "$OSTYPE" = darwin* ]] && [[ `hostname -s` = "nitrogen" ]]; then
    export PILLAR_PATH=~/Code/jwp/pillar
fi

# FINALLY, do syntax highlight, etc.
source $slim_path/extras/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $slim_path/extras/zsh-history-substring-search/zsh-history-substring-search.zsh
