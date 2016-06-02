slim_path=`dirname $0`
fpath=(/usr/local/share/zsh-completions $slim_path $fpath)

autoload -U promptinit && promptinit
prompt pure

autoload -U compinit
compinit

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

# load submods
source $slim_path/submod/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $slim_path/submod/zsh-history-substring-search/zsh-history-substring-search.zsh

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

