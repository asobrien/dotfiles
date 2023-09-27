# vim:ts=4:et:ft=zsh
#
# zsh config
#

# env vars
export NO_COLOR=1   # no rose-colored glasses for me
export LESSHISTFILE=-   # disable
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state
export GOPATH="$XDG_DATA_HOME"/go
export GOMODCACHE="$XDG_CACHE_HOME"/go/mod
export PATH=~/bin:/sbin:/usr/sbin:/bin:/usr/bin:/usr/X11R6/bin:/opt/local/sbin:/usr/local/sbin:/opt/local/bin:/usr/local/bin:${GOPATH:-~}/bin

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

# work
alias kraken='AWS_PROFILE=giphy kraken' # its usually where i want to be

# ZSH opts
bindkey -e                      # always use emacs-style control
export HISTFILE="$HOME/.zhistory"
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

# # End of lines configured by zsh-newuser-install
# # The followinge lines were added by compinstall
# zstyle :compinstall filename '$HOME/.zshrc'
# autoload -Uz compinit
# compinit
# # End of lines added by compinstall
# #

# mark this dir; use gd to enter
md() {
  local f=~/.zsh_mdir
  if [ ! -f $f ]; then
      touch $f && chmod 0600 $f
  fi
  pwd >! $f
}

# goto marked dir; use md to set
gd() {
  local f=~/.zsh_mdir
   if [ -f $f ]; then
      if [ -d "`cat $f`" ]; then
         cd "`cat $f`"
      else
         rm -f $f
      fi
   fi
}

# precmd () {
#     print -Pn "\e]1; %~\a" # title bar prompt
# }
# 
# # Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
# export PATH="$PATH:$HOME/.rvm/bin"
