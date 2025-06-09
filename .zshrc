autoload -Uz compinit && compinit
autoload -Uz vcs_info


#
TERM=kitty
EDITOR=nvim

bindkey -v


# Set expansion of variables in prompts
setopt prompt_subst 

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' formats '%F{#cba6f7}%f %F{#89b4fa}%b%f %m%u%c %a'
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr ' %F{green}✚%f'
zstyle ':vcs_info:*' unstagedstr ' %F{red}●%f'

precmd() { 
    vcs_info
    print -P '%B%~%b ${vcs_info_msg_0_}'
}
PROMPT='%B%(!.#.$)%b '
