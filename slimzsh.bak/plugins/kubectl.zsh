# Autocompletion for kubectl, the command line interface for Kubernetes
#
# Author: https://github.com/pstadler
# SRC: https://github.com/robbyrussell/oh-my-zsh/blob/master/plugins/kubectl/kubectl.plugin.zsh

if [ $commands[kubectl] ]; then
  source <(kubectl completion zsh)
fi

if [ $commands[kops] ]; then
  source <(kops completion zsh)
fi