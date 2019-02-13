# This plugin loads opam into the current shell and provides prompt info via
# the 'opam_prompt_info' function.

FOUND_OPAM=$+commands[opam]

if [[ $FOUND_OPAM -eq 1 ]]; then
  eval $(opam env --shell=zsh)

  function opam_prompt_info(){
    local switch="$(opam switch show)"
    [[ $switch == '/'* ]] && echo "${ZSH_THEME_OPAM_PROMPT_PREFIX:=[}${switch:t}${ZSH_THEME_OPAM_PROMPT_SUFFIX:=]}"
  }

  function opam_env_hook() {
    eval $(opam env --shell=zsh)
  }
  if [[ -z ${precmd_functions[(r)opam_env_hook]} ]]; then
     precmd_functions+=opam_env_hook
  fi
else
  function opam_prompt_info(){
  }
fi

unset FOUND_OPAM
