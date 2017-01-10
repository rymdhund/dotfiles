#!/bin/sh

if [ -f ~/.tmux.conf ]; then
  echo "~/.tmux.conf already exists!"
  exit 1
fi

ln -s ~/dotfiles/tmux.conf ~/.tmux.conf
