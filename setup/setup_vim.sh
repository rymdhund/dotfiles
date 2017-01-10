#!/bin/sh

if [ -f ~/.vimrc ]; then
  echo "~/.vimrc already exists!"
  exit 1
fi

ln -s ~/dotfiles/vimrc ~/.vimrc
