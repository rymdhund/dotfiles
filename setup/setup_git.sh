#!/bin/sh

if [ -f ~/.gitconfig ]; then
  echo "~/.gitconfig already exists!"
  exit 1
fi

ln -s ~/dotfiles/gitconfig ~/.gitconfig
