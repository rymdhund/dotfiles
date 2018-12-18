export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="rymdhund"
DISABLE_AUTO_UPDATE="true"

plugins=(git vi-mode zsh-syntax-highlighting history-substring-search docker docker-compose)

source $ZSH/oh-my-zsh.sh

############
# Settings #
############
bindkey '^R' history-incremental-search-backward

export HISTSIZE=10000
export SAVEHIST=10000
export HISTFILE=~/.zsh_history
export EDITOR=vim
export KEYTIMEOUT=1  # short delay for escape

###########
# Aliases #
###########

alias aoeu='setxkbmap se'
alias asdf='setxkbmap sedvorak'

# tmux to fix vim colors
alias tmux="TERM=screen-256color-bce tmux"

alias vim=nvim

# git
alias gl='git pull'
alias gp='git push'
alias gd='git diff'
alias gc='git commit'
alias gca='git commit -a'
alias gco='git checkout'
alias gb='git branch'
alias gs='git status'
alias grm="git status | grep deleted | awk '{print \$3}' | xargs git rm"

# virtualenv
alias envup="source env/bin/activate"

# docker
alias docker-rm-all-containers='docker ps -q -a | xargs docker rm'
alias docker-rm-untagged-images='docker images -q --filter "dangling=true" | xargs docker rmi'

# ip stuff
alias myip="dig +short myip.opendns.com @resolver1.opendns.com"
alias ips="/sbin/ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"


if [ -f $HOME/.environ ]; then
  source $HOME/.environ
fi

setopt null_glob
for f in $HOME/.zsh.d/*; do
  source $f
done

export PATH=$HOME/.local/bin:$PATH
