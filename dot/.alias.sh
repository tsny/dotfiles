# Misc
alias ll="ls -la --color"
alias ls="ll"
alias ..="cd .."

alias lvl="echo $SHLVL"
alias ydla="youtube-dl -x --audio-format mp3"

alias bts="sh ~/dev/dotfiles/bootstrap.sh;"
alias ppath='printf "%s\n" $path'

# Git 
alias gpl="git pull"
alias gc="git commit"
alias gac="git commit -a"
alias gca="git commit --amend"
alias gcb="git checkout -b"
alias gco="git checkout"
alias gct="git checkout --theirs"
alias gat="git checkout --theirs"
alias guc="git add -u; git commit"
alias guf="git add -A; git commit -m 'Fast update commit'"
alias gcd="git checkout develop"

alias gac="git add -A; git commit"
alias gps="git push"
alias gst="git status"
# git diff
alias giff="git diff -- . ':(exclude)*_gen.go'"
# giff all
alias giffa="git diff"
alias glog="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

# PayPal specific
alias gpud="git pull upstream develop"
alias gpudr="git pull --rebase upstream develop"

alias gmt="go mod tidy"
alias gorm="go run main.go"

# Fetches all remote branches so they can be fed into fzf for easy navigation 
function gfar() {
    for remote in `git branch -r`; do git branch --track ${remote#origin/} $remote; done
}

# Docker
if command -v docker &> /dev/null 
then
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
fi

# AWS
alias ebs='aws elasticbeanstalk'
