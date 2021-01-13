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
#bind '"\C-k":"ls -l\n"'
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
    source ~/tc_bash.sh
fi

## Rust
PATH=~/.cargo/bin:$PATH
PATH="$HOME/.cargo/bin:$PATH"
PATH="$HOME/.gem/ruby/2.6.0/bin:$PATH"
PATH="/opt/oracle/instantclient_12_2:$PATH"
export PATH="~/.fzf/bin:$PATH"
export DYLD_LIBRARY_PATH="/opt/oracle/instantclient_12_2"
export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/lib/pkgconfig
source /Users/cn168865/dev/obsidian-tools/oo-k8s.sh
