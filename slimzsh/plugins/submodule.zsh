# initialize a submodule if required
for submod ($slim_path/submod/*); do
  [[ ! -d "$submod" ]]
  echo
  echo "Initializing submodules ..."
  echo
  cd $HOME/.dotfiles
  git submodule init
  git submodule update
  cd -
  unset submod
  break
done