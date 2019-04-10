#!/bin/sh

set -e

# remove cruft installed by default in openbsd
rm -f ~/.cshrc \
	~/.login \
	~/.mailrc \
	~/.profile \
	~/.Xdefaults \
	~/.cvsrc

# don't keep my history
for f in .bash_history .sqlite_history .mysql_history; do
	rm -f ~/$f
	ln -s /dev/null ~/$f
done

if [ -d ~/.dotfiles ]; then
	cd ~/.dotfiles
	git pull --ff-only
	git submodule update --init --recursive
else
	git clone --recursive https://github.com/asobrien/dotfiles ~/.dotfiles
fi

cd ~/.dotfiles
for f in .???*; do
	rm -f ~/$f
	(cd ~/; ln -s .dotfiles/$f $f)
done

# don't pollute ~/ with meta dotfiles
for f in .git .gitignore .gitmodules; do
    if [ -L "~/$f" ]; then
        rm -f ~/$f
    fi
done
