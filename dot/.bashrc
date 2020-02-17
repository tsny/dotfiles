# If not running interactively, don't do anything
[[ $- != *i* ]] && return

echo  
echo  "    __                   "
echo  "   / /__________  __  __ "
echo  "  / __/ ___/ __ \/ / / / "
echo  " / /_(__  ) / / / /_/ /  "
echo  " \__/____/_/ /_/\___ /   "
echo  "               /____/    "
echo  

### VIM Movement

export EDITOR=VIM
export VISUAL=VIM
set -o vi
bind '"jk":vi-movement-mode'

### Aesthetic

PROMPT_COMMAND="echo"

### Bindings

bind '"\C-l":"clear\n"'
bind '"\C-k":"ls -la\n"'

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

if [ -f ~/alias.sh ]; then
    source ~/alias.sh
fi

## Load custom fzf settings

## FZF
if [ -f ~/.fzf.bash ]; then
    source ~/.fzf.bash
fi

### Work/Home 

if [ -f ~/tc_bash.sh ]; then
    echo "Loading work settings..."
    source ~/tc_bash.sh
else 
    echo "Loading home settings..."
fi

## Rust
PATH=~/.cargo/bin:$PATH

## New line for prompt
PS1="$PS1\n " 
PS1="$PS1:\[\e[f\e[K\]"

if exa -v; then
    alias ls="exa"
    alias ll="exa -l"
fi

export PATH

export PATH="$HOME/.cargo/bin:$PATH"
export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"
export PATH="~/.fzf/bin:$PATH"
export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/lib/pkgconfig
