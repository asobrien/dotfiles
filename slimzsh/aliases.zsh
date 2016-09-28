# UTILITY
alias less='less -R'
alias grep='grep --color=auto'
alias ..='cd ../'

# colors with ls
if [[ -x "`whence -p dircolors`" ]]; then
  eval `dircolors`
  alias ls='ls -F --color=auto'
else
  alias ls='ls -F'
fi


# GIT
# alias gd='git diff'
# alias gco='git checkout'
# alias gs='git status'
# alias gl='git pull'
# alias gp='git push'
# alias gpp='git pull; git push'
alias gwc='git whatchanged -p --abbrev-commit --pretty=medium'
alias gg='git log --oneline --abbrev-commit --graph --decorate --color'

# SOURCE CUSTOM ALIASES
if [[ -f $slim_path/aliases.zsh.local ]]; then
  source $slim_path/aliases.zsh.local
fi

# DEBIAN/UBUNTU
alias apt-get-doit='apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" dist-upgrade'