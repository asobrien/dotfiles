.dotfiles
=========

Quickstart
----------
Grab 'em:

```
git clone git@github.com:asobrien/dotfiles.git $HOME/.dotfiles
$HOME/.dotfiles/dotctl
```

and go!

If your default shell is not zsh:
```
sudo apt-get install -y zsh  # or equivalent
chsh -s $(which zsh)
```


This is designed to be used as a repo, or provisioned. That means we make
a few compromises.

Standalone Installation
-----------------------
Used outside the scope of provisioning. Clone the repo

```
git clone git@github.com:URL ~/.dotfiles

# or http:

git clone https://URL ~/.dotfiles
```

And then we can activate the dotfiles. In the case of provisioning, we
are largely copying a bunch on dotfiles into place (why?)... I guess so
they are where we expect. 

But let's set this up so we don't really need a provisioning run to get
things under control... or, conversely, on can always, update dotfiles.


What we should run on a provisioned box is:

```
rsync --exclude '.git/' -ah --no-perms /home/{{user}}/.dotfiles/ /home/{{user}}
```

but we want to excludes some additional files without breaking the above command,
so we do that like this:

```
[[ -f "~/dotfiles/no.txt" ]] && foo="~/dotfiles/no.txt" || foo=""; \
  rsync --exclude '.git/' --exclude-from=${dotignore} -ah --no-perms /home/{{user}}/.dotfiles/ /home/{{user}}
```

Now, one can self provision like this (if required):

```
    [[ -f "$HOME/.dotfiles/.dotignore" ]] && dotignore="$HOME/.dotfiles/.dotignore" || dotignore=""; \
        rsync --exclude '.git*' \
              --exclude-from="${dotignore}" \
              -ah --no-perms \
              $HOME/.dotfiles/ $HOME
```

we save the trouble with a bootstrap utility.

### Alternate Repo location ###
Not a problem, just create a symlink:
```
ln -s path/to/repo .dotfiles
```
