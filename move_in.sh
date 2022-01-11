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
# for f in .bash_history .sqlite_history .mysql_history; do
# 	rm -f ~/$f
# 	ln -s /dev/null ~/$f
# done

if [ -d ~/.dotfiles ]; then
	cd ~/.dotfiles
	git pull --ff-only
	git submodule update --init --recursive
else
	git clone --recursive https://github.com/asobrien/dotfiles ~/.dotfiles
fi

cd ~/.dotfiles
for f in .???*; do
    # don't pollute ~/ with meta dotfiles
    if [[ "$f" == ".git" || "$f" == ".gitignore" || "$f" == ".gitmodules" ]]; then
        continue
    fi
	rm -f ~/$f
	(cd ~/; ln -s .dotfiles/$f $f)
done

# fill ~/.config with the contents of _config
if [ ! -d ~/.config ]; then
    mkdir -p ~/.config
fi
for s in _config/*; do
    f=$(echo $s | sed 's/^_/\./')
    rm -f ~/$f
    (cd ~/; ln -s .dotfiles/$s $f)
done
