# opam Oh-My-ZSH plugin

[opam](https://opam.ocaml.org/) package manager for ocaml.

This plugin initializes opam and provides the `opam_prompt_info` for themes to add opam local switch information to prompts.

To use, add `opam` to your plugins array in your zshrc file:

```zsh
plugins=(... opam)
```

## Configuration

You can modify your `$PROMPT` or `$RPROMPT` variables to run `opam_prompt_info`.

For example:
```
PROMPT="$(opam_prompt_info)%~$ "
```
changes your prompt to:
```
[project]~/ocaml/project$
```

You can configure these variables as well:
```
ZSH_THEME_OPAM_PROMPT_PREFIX="%{$fg_bold[magenta]%}"
ZSH_THEME_OPAM_PROMPT_SUFFIX="%{$reset_color%}"
```
