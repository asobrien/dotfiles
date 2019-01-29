# vim:ts=3:et:ft=zsh
#
# zshell config
# joshua stein <jcs@jcs.org>
#

# environment variables
export BLOCKSIZE=1k
export CVS_RSH=/usr/bin/ssh
export IRCNAME="*Unknown*"

# pass through to bash in case it somehow gets invoked
export HISTFILE=

# always allow case insensitive searching when using less
export LESS="-i"

# ow my security
export MYSQL_HISTFILE=/dev/null

# get off my lawn
export NO_COLOR=1

export PATH=~/bin:~/go/bin:/usr/local/bin:/usr/local/sbin:/bin:/usr/bin:/sbin:/usr/sbin:/usr/X11R6/bin

# let control+w only delete one directory of a path, not the whole word
export WORDCHARS='*?_[]~=&;!#$%^(){}'

# on non-interactive shells, just exit here to speed things up
if [[ ! -o interactive ]]; then
   return
fi

# zsh will try to use vi key bindings because of the vi $EDITOR, but i want
# emacs style for control+a/e, etc.
bindkey -e

# i want to search with up/down arrow keys
# https://superuser.com/a/585004
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search # Up
bindkey "^[[B" down-line-or-beginning-search # Do

# i'm too lazy to type these out
alias calc='perl -pe "print eval(\$_) . chr(10);"'
alias cdu='cvs -q diff -upRN'
alias clip='xclip -in -selection clipboard'
alias cp='cp -i'
alias hg='history | grep '
alias jobs='jobs -p'
alias k9='kill -9 %1'
alias ll='ls -alF'
alias lo='logout'
alias ls='ls -aF'
alias manfile='groff -man -Tascii \!* | less'
alias mv='mv -i'
alias offline_mutt='mutt -R -F ~/.muttrc.offline'
alias pastebin="curl -F 'f:1=<-' ix.io"
alias ph='ps auwwx | head'
alias pg='ps auwwx | grep -i -e ^USER -e '
alias publicip='curl -s http://ifconfig.me'
alias refetch='cvs -q up -PACd'
alias telnet='telnet -K'
alias tin='tin -arQ'
alias u='cvs -q up -PAd'
# serve up the current directory
alias webserver="ifconfig | grep 'inet ' | grep -v 127.0.0.1; python -m SimpleHTTPServer"

# when i say vi i mean vim (if it's installed)
if [ -x "`which vim`" ]; then
   alias vi='vim'
   alias view='vim -R'
   export EDITOR=`which vim`
else
   export EDITOR=/usr/bin/vi
fi

# options
setopt noclobber                     # halp me
setopt nohup                         # don't kill things when i logout
setopt print_exit_value              # i want to know if something went wrong
HISTFILE=~/.zhistory
HISTSIZE=500
SAVEHIST=10000
HISTCONTROL=ignoredupes              # i don't expect the same thing to give different results
setopt append_history                # all my eggs in one basket
setopt extended_history              # i want to know when this happened
setopt hist_expire_dups_first        # remove old duplicate events first
setopt hist_ignore_dups              # don't add repeats to history
setopt hist_ignore_space             # prepend secret things with a <space> for no history
setopt hist_verify                   # verify expansions before executing
setopt inc_append_history            # write events as they happen so they show in other terms
PS1='%n@%m:%~%(!.#.>) '              # prompt
TMOUT=0                              # don't auto logout

# i am frequently too quick to logout with control+d twice (one to exit ssh,
# another to close the terminal) and will miss the 'you have suspended jobs'
# message, so hitting it twice still logs me out.  prevent that by not sending
# eof on control+d but manually bind to it and run a function that exits.
setopt ignore_eof
_block_quick_bail() {
   _sj=`jobs -sp`
   if [[ $_sj == "" ]]; then
      exit
   else
      _sj=$'\n'${_sj}
      zle -M "zsh: you have suspended jobs:${_sj}"
   fi
}
zle -N _block_quick_bail
bindkey '^d' _block_quick_bail

# show all logins and such
watch=all
WATCHFMT="%B%n%b %a %l at %@"

# etc
limit coredumpsize 0                 # don't know why you'd want anything else
umask 022                            # be nice

autoload -Uz compinit
compinit

# os-specific tweaks

# mac os
if [[ $OSTYPE = darwin* ]]; then
   alias ldd='otool -L'
   alias sha1='openssl dgst -sha1'

   # update dotfiles
   alias update_dotfiles='curl https://raw.githubusercontent.com/jcs/dotfiles/master/move_in.sh | sh -x -'

   # bring in rbenv
   if [ -d /usr/local/Cellar/rbenv ]; then
       export PATH="${HOME}/.rbenv/shims:${PATH}:/opt/X11/bin"
       source /usr/local/Cellar/rbenv/*/completions/rbenv.zsh;
   fi

   export STORE_LASTDIR=1
   # export DEVELOPER_DIR="/Applications/Xcode.app/Contents/Developer"

   # show upcoming events with icalBuddy, but because it's slow, show the
   # cached version and update the cache in the background
   if [ -x /usr/local/bin/icalBuddy ]; then
       ICAL_BUDDY="icalBuddy -li 3 -eed -n -npn -nc -iep 'title,datetime' \
          -ps '| - |' -po 'datetime,title' -b '' -tf '%H:%M' eventsToday+7"
       _AGE=0
       if [ -f ~/.icalcache ]; then
          # but if the cache is more than 6 hours old, it's not helpful to show
          # an old cache, so force it to be re-run
          _CACHE_MTIME=`stat -f "%m" ~/.icalcache`
          _AGE=$((`date "+%s"` - $_CACHE_MTIME))
          if [ $_AGE -gt 28800 ]; then
             rm -f ~/.icalcache
          fi
       fi
       if [ -f ~/.icalcache ]; then
          cat ~/.icalcache
          sh -c "${ICAL_BUDDY} > ~/.icalcache &" > /dev/null
       else
          eval ${ICAL_BUDDY} | tee ~/.icalcache
       fi
   fi

# openbsd
elif [[ $OSTYPE = openbsd* ]]; then
   alias watchbw='netstat -w1 -b -I'

   # for ports
   alias remake='cd ../../; rm w-*/.build*; make; cd -'

# loonix
elif [[ $OSTYPE = linux* ]]; then
   alias ls='ls -aFv'
   alias ph='ps auwwx | sort -rk 3,3 | head'
fi

# and the reverse
if [[ $OSTYPE != linux* ]]; then
   # siginfo
   stty status '^T'
fi

if [[ $OSTYPE != darwin* ]]; then
   watch=

   alias pbcopy='xclip -in -selection clipboard'
fi

case $TERM in
    xterm*)
        precmd() {print -Pn "\e]0;%m:%~>\a"}
        preexec() {print -Pn "\e]0;%m:%~> $1\a"}
    ;;
esac

if [ -f ~/.zshrc.local ]; then
   source ~/.zshrc.local
fi

if [ "$STORE_LASTDIR" = "1" ]; then
   # now go to the last dir that was there
   chpwd() {
      pwd >! ~/.zsh.lastdir
   }

   if [ -f ~/.zsh.lastdir ]; then
      if [ -d "`cat ~/.zsh.lastdir`" ]; then
         cd "`cat ~/.zsh.lastdir`"
      else
         rm -f ~/.zsh.lastdir
      fi
   fi
fi
