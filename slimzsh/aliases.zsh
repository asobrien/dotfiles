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

# Calendaring
alias agenda='gcalcli --calendar asobrien@jwplayer.com agenda "10 minutes ago" tomorrow'
alias isodate='date -u +"%Y-%m-%dT%H:%M:%SZ"'

##################
#  LTV
##################
# update salt repos on salt-dev
alias ltv-dev-salt-pull="ssh salt-dev.longtailvideo.com 'cd /opt/ltv/provisioning/salt && git fetch && git merge FETCH_HEAD'"
alias ltv-dev-pillar-pull="ssh salt-dev.longtailvideo.com 'cd /opt/ltv/provisioning/pillar && git fetch && git merge FETCH_HEAD'"

##################
#  FUNCTIONS
##################

# a prettier less, with syntax highlighting
pless() {
    local has_pygments=`command -v pygmentize >/dev/null 2>&1`

    if [ $? ]; then
        pygmentize -f terminal256 -O style=vim $* | less -R
    else
        echo >&2 "Pygments not found.";
        less $*
    fi
}

# install packages from ltv devpi
pip-ltv() {
  PIP_INDEX_URL="https://devpi.longtailvideo.com/root/ltv/+simple/" \
    pip $*
}