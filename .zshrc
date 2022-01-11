# vim:ts=4:et:ft=zsh
#
# zsh config

# no rose-colored glasses
export NO_COLOR=1

export PATH=/opt/local/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin

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

# work
alias kraken='AWS_PROFILE=giphy kraken' # its usually where i want to be

# when i say vi i mean vim (if it's installed)
if [ -x "`which vim`" ]; then
    alias vi='vim'
    alias view='vim -R'
    export EDITOR=`which vim`
else
    export EDITOR=/usr/bin/vi
fi







# options

# always use emacs-style control+a/e, etc.
# despite whatever my $EDITIOR may be
bindkey -e  # always use emacs-style control

# Lines configured by zsh-newuser-install
# history
export HISTFILE="$HOME/.zhistory"
export HISTSIZE=10000
export SAVEHIST=$HISTSIZE
setopt BANG_HIST        # treat bang specially during expansion
setopt EXTENDED_HISTORY # i want to know when events happened
setopt INC_APPEND_HISTORY # write history as it happens, not on exit
setopt SHARE_HISTORY # share history between shells
setopt HIST_IGNORE_SPACE  # prepend secrets with <space> to suppress
setopt HIST_EXPIRE_DUPS_FIRST # remove old duplicate events first
setopt HIST_IGNORE_DUPS # don't add repeats to history
setopt HIST_VERIFY # verify expansions before executing
export SHELL_SESSIONS_DISABLE=1 # don't write ~/.zsh_sessions

# prompt
PS1="%n@%m:%1~%(!.#.$) "

# End of lines configured by zsh-newuser-install
# The followinge lines were added by compinstall
zstyle :compinstall filename '$HOME/.zshrc'
autoload -Uz compinit
compinit
# End of lines added by compinstall
#

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

precmd () {
    print -Pn "\e]1; %~\a" # title bar prompt
}
