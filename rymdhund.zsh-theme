# Copied and modified from the oh-my-zsh theme from geoffgarside
# Red server name, green cwd, blue git status

hg_ps1(){
}

# ignore opam_prompt_info if not exists
functions opam_prompt_info >& /dev/null || opam_prompt_info(){}

PROMPT='$(opam_prompt_info)%{$fg[red]%}%m%{$reset_color%}:%{$fg[green]%}%~%{$reset_color%}$(git_prompt_info)%{$reset_color%}$(git_prompt_status)%{$reset_color%}$(hg_ps1)%(!.#.$) '

ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg[blue]%}("
ZSH_THEME_GIT_PROMPT_SUFFIX=")%{$reset_color%}"

ZSH_THEME_GIT_PROMPT_DIRTY=""
ZSH_THEME_GIT_PROMPT_CLEAN=""

ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%}✚"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[blue]%}✹"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%}✖"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[magenta]%}➜"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[yellow]%}═"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[cyan]%}✭"
ZSH_THEME_GIT_PROMPT_STASHED="%{$fg[blue]%}☰"
