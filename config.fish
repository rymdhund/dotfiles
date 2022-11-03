set -gx EDITOR nvim

# Git prompt
set __fish_git_prompt_showdirtystate true
set __fish_git_prompt_showstashstate true
set __fish_git_prompt_showuntrackedfiles true
set __fish_git_prompt_color_branch yellow
set __fish_git_prompt_color_dirtystate blue
set __fish_git_prompt_color_untrackedfiles blue
set __fish_git_prompt_color_stagedstate green
set __fish_git_prompt_color_upstream_ahead green
set __fish_git_prompt_color_upstream_behind red

set __fish_git_prompt_char_dirtystate '✹'
set __fish_git_prompt_char_stagedstate '✚'
set __fish_git_prompt_char_untrackedfiles '✭'
set __fish_git_prompt_char_stashstate '☰'
set __fish_git_prompt_char_upstream_ahead '+'
set __fish_git_prompt_char_upstream_behind '-'

# vim
alias vim='nvim'

# bat
alias bat='bat -p --theme GitHub'

# git
alias ga='git add'
alias gl='git pull'
alias gp='git push'
alias gd='git diff'
alias gc='git commit'
alias gca='git commit -a'
alias gco='git checkout'
alias gb='git branch'
alias gs='git status'
alias grm="git status | grep deleted | awk '{print \$3}' | xargs git rm"
