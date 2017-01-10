#!/bin/bash

if [ -f ~/.zshrc ]; then
  echo "~/.zshrc already exists!"
  exit 1
fi

if [ -d ~/.oh-my-zsh ]; then
  echo "~/.oh-my-zsh already exists!"
  exit 1
fi

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | grep -v 'env zsh')"
ln -s ~/dotfiles/rymdhund.zsh-theme  ~/.oh-my-zsh/themes/rymdhund.zsh-theme
ln -s ~/dotfiles/zshrc ~/.zshrc
