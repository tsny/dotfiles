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

### Colors

if [ -f ~/.colors ]; then
    echo "Loading colors..."
    source ~/.colors
fi

# VIFM for WinBash

if [ "$(uname)" == "Darwin" ]; then
    echo 
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    # Do something under GNU/Linux platform
    echo 
elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]; then
    # Do something under 32 bits Windows NT platform
    alias vifm="winpty vifm"
elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW64_NT" ]; then
    # Do something under 64 bits Windows NT platform
    alias vifm="winpty vifm"
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

# fzf
alias fd='`__fzf_cd__`'

# Misc

alias ll="ls -l"
alias clear="clear"
alias c="clear"
alias ..="cd .."
alias q="exit"
alias fm="vifm"

alias ydla="youtube-dl -x --audio-format mp3"

alias ogc="open -a 'Google Chrome'"
alias bts="sh ~/dev/dotfiles/bootstrap.sh;"
alias ppath="tr ':' '\n' <<< \"$PATH\""

# CD Locations

alias h="cd ~"
alias dv="cd ~/dev"
alias nt="cd ~/notes"
alias dc="cd ~/Documents"
alias ss="cd ~/screenshots"
alias dl="cd ~/Downloads"
alias gg="cd ~/dev/go/src"
alias dsk="cd ~/Desktop"
alias dot="cd ~/dev/dotfiles/"
alias jr="cd ~/notes/journal"

# Quick edits

alias ebrc="vi ~/dev/dotfiles/dot/.bashrc"
alias evrc="vi ~/dev/dotfiles/dot/.vimrc"

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

### Mac 

if [ -f ~/tc_bash.sh ]; then
    echo "Loading work settings..."
    source ~/tc_bash.sh
else 
    echo "Loading home settings..."
fi

## alias fd='`__fzf_cd__`'
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
PS1="$PS1\n " 
