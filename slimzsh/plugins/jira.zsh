# Autocompletion for go-jira cli tool
#
# Author: Anthony O'Brien
# REF: https://github.com/Netflix-Skunkworks/go-jira#setting-up-tab-completion 

if [ $commands[jira] ]; then
  eval "$(jira --completion-script-zsh)"
fi
