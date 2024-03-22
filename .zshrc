# vim:ts=4:et:ft=zsh
#
# zsh config
#

# env vars
export NO_COLOR=1   # no rose-colored glasses for me
export LESSHISTFILE=-   # disable
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export GOPATH="$XDG_DATA_HOME/go"
export GOMODCACHE="$XDG_CACHE_HOME/go/mod"
export PATH=~/bin:/sbin:/usr/sbin:/bin:/usr/bin:/usr/X11R6/bin:/opt/local/sbin:/usr/local/sbin:/opt/local/bin:/usr/local/bin:${GOPATH:-~/go}/bin

# on non-interactive shells, duck and roll
if [[ ! -o interactive ]]; then
    return
fi

# aliases
alias ..='cd ../'
alias ../..='cd ../../'
alias ../../..='cd ../../../'
alias ../../../..='cd ../../../..'      # i'm too lazy to type these out
alias cp='cp -i'                        # ask nicely
alias ls='ls -aF'                       # show all files and indicate type
alias mv='mv -i'                        # ask nicely
alias telnet='telnet -K'                # no autologin
alias ag='ag --nocolor'                 # this is .agrc
alias gitroot='git rev-parse --show-toplevel'
alias cd@='cd $(gitroot)'

# application defaults
export ACKRC="$XDG_CONFIG_HOME/ack/ackrc"
alias kraken='AWS_PROFILE=${AWS_PROFILE:-giphy} kraken' # its usually where i want to be
export MYSQL_HISTFILE="$XDG_DATA_HOME"/mysql_history

# ZSH opts
bindkey -e                      # always use emacs-style control
export HISTFILE="$XDG_STATE_HOME/zsh/history"
export HISTSIZE=10000
export SAVEHIST=$HISTSIZE
setopt BANG_HIST                # treat bang specially during expansion
setopt EXTENDED_HISTORY         # i want to know when events happened
setopt INC_APPEND_HISTORY       # write history as it happens, not on exit
setopt SHARE_HISTORY            # share history between shells
setopt HIST_IGNORE_SPACE        # prepend secrets with <space> to suppress
setopt HIST_EXPIRE_DUPS_FIRST   # remove old duplicate events first
setopt HIST_IGNORE_DUPS         # don't add repeats to history
setopt HIST_VERIFY              # verify expansions before executing
setopt print_exit_value         # ignorance isn't bliss

# history-search
bindkey "^[[A" history-beginning-search-backward    # up-arrow
bindkey "^[[B" history-beginning-search-forward     # down-arrow

# prompt
PS1="%n@%m:%1~%(!.#.$) "
autoload -Uz compinit; compinit -d "$XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION" # tab completion
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/zcompcache"

# addons (e.g., stows)
for f in $XDG_CONFIG_HOME/zsh/conf.d/*; do
    source "$f"
done

# open ag search results within vim quickfix
vag() {
  pattern=$1
  shift
  vim +"Ack '$pattern' $*"
}

# mark this dir; use gd to enter
md() {
  local f=$XDG_STATE_HOME/zsh/mdir
  if [ ! -f $f ]; then
      mkdir -p -- $f:h && touch $f && chmod 0600 $f
  fi
  pwd >! $f
}

# goto marked dir; use md to set
gd() {
  local f=$XDG_STATE_HOME/zsh/mdir
   if [ -f $f ]; then
      if [ -d "`cat $f`" ]; then
         cd "`cat $f`"
      else
         rm -f $f
      fi
   fi
}
