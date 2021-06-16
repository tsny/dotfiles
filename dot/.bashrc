# If not running interactively, don't do anything
[[ $- != *i* ]] && return

### VIM Movement

export EDITOR=VIM
export VISUAL=VIM
set -o vi
bind '"jk":vi-movement-mode'

### Aesthetic

PROMPT_COMMAND="echo"

### Bindings

bind '"\C-l":"clear\n"'
bind -x '"\C-k": "ls -l"'
bind '"\C-n":"\u0001b[A"'

### Colors

if [ -f ~/.bash-powerline.sh ]; then
    source ~/.bash-powerline.sh
fi

### Aliases

# Color based on OS

if [[ "$OSTYPE" == "darwin"* ]]; then
    alias ls="ls -Ga"
else
    alias ls="ls --color"
    alias e="start gvim --remote-tab-silent"
fi

if [ -f ~/.alias.sh ]; then
    source ~/.alias.sh
fi

## FZF
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
[ -f ~/tsny-fzf.sh ] && source ~/tsny-fzf.sh

export PATH="~/.fzf/bin:$PATH"
