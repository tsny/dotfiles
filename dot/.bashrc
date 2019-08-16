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

bind -x '"\C-k":"clear"'

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

# Programming

alias py3="python3"
alias py="python"
alias gorm="go run main.go"

# Misc

alias ll="ls -l"
alias ..="cd .."
alias fm="vifm"

alias reload="exec bash"
alias lvl="echo $SHLVL"

alias ydla="youtube-dl -x --audio-format mp3"

alias ogc="open -a 'Google Chrome'"
alias bts="sh ~/dev/dotfiles/bootstrap.sh;"
alias ppath="tr ':' '\n' <<< \"$PATH\""

# Git Stuff

alias gup="git add -u"
alias gpl="git pull"
alias gc="git commit"
alias gac="git commit -a"
alias gcb="git checkout -b"
alias gco="git checkout"
alias guc="git add -u; git commit"
alias guf="git add -A; git commit -m 'Fast update commit'"
alias gac="git add -A; git commit"
alias gps="git push"
alias gst="git status"
alias giff="git diff"
alias glog="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

# Docker

alias dm='docker-machine'
alias dps='docker ps'
alias dmx='docker-machine ssh'
alias dk='docker'
alias dki='docker images'
alias dks='docker service'
alias dkrm='docker rm'
alias dkl='docker logs'
alias dklf='docker logs -f'
alias dkflush='docker rm `docker ps --no-trunc -aq`'
alias dkflush2='docker rmi $(docker images --filter "dangling=true" -q --no-trunc)'
alias dkt='docker stats --format "table {{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}\t{{.NetIO}}"'
alias dkps="docker ps --format '{{.ID}} ~ {{.Names}} ~ {{.Status}} ~ {{.Image}}'"


## Helper method to see if app exists
command_exists () {
    type "$1" &> /dev/null;
}


### Bookmark Functions
bm() {
    local curr_dir="${PWD}"
        if ! grep -Fxq "$curr_dir" ~/.shell_bookmarks; then
            echo "$curr_dir" >> ~/.shell_bookmarks
        else 
            echo "$PWD already bookmarked"
        fi
}

gg() {
     local dest_dir=$(cat ~/.shell_bookmarks | fzf )
       if [[ $dest_dir != '' ]]; then
          cd "$dest_dir"
       fi
}

### Bindings

bind '"\C-b":"gg\n"'

### Work/Home 

if [ -f ~/tc_bash.sh ]; then
    echo "Loading work settings..."
    source ~/tc_bash.sh
else 
    echo "Loading home settings..."
fi

## Rust
PATH=~/.cargo/bin:$PATH

## FZF
if [ -f ~/.fzf.bash ]; then
    source ~/.fzf.bash
    source ~/.tsny.fzf
fi

## New line for prompt
PS1="$PS1\n " 


## Check for exa
if command_exists exa;  then
    alias ls="exa"
    alias ll="exa -l"
fi

export PATH
