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

get_ssl_cert() {
  local SSL_CERT_HOST="${1}"
  local CA_CERTS=""

  if [[ `uname` == "Darwin2" ]]; then
    CA_CERTS=("-CAfile" "/usr/local/etc/openssl/cert.pem")
  elif [[ `uname` == "Linux" ]]; then
    CA_CERTS=("-CApath" "/etc/ssl/certs/")
  else
    (>&2 echo '\033[1;33mNo CA certs found; you may see verification errors\033[0m')
  fi

  echo "Q" | openssl s_client ${CA_CERTS[@]} -connect ${SSL_CERT_HOST}:443 | openssl x509 -noout -text
}

# Open today's logbook
lb() {
    vim ~/logbook/$(date '+%Y-%m-%d').md
}

# automatic tmux session
automux() {
  local SESSION=${1:-base}
  [[ $- == *i* && $SSH_TTY && -z $TMUX && ! -r ~/.notmux ]] && tmux -CC attach-session -t ${SESSION} || tmux -CC new -s ${SESSION} && exit
}
