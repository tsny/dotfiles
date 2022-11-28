export FZF_DEFAULT_COMMAND="fd -I --exclude={.git,.idea,.vscode,.sass-cache,node_modules,build,Music,Pictures} --type f"
export FZF_ALT_C_COMMAND="fd --type d"
export FZF_DEFAULT_OPTS="--height 60% --layout=reverse --border"

## fzf stuff, check a few places for config files
[[ ! -f ~/usr/share/fzf/completion.zsh ]] || source ~/usr/share/fzf/completion.zsh
[[ ! -f ~/usr/share/fzf/key-bindings.zsh ]] || source ~/usr/share/fzf/key-bindings.zsh
[[ ! -f ~/.fzf/shell/key-bindings.zsh ]] || source ~/.fzf/shell/key-bindings.zsh
[[ ! -f ~/.fzf/shell/completion.zsh ]] || source ~/.fzf/shell/completion.zsh

[[ ! -f /usr/local/Cellar/fzf/0.34.0/shell/completion.zsh ]] || source /usr/local/Cellar/fzf/0.34.0/shell/completion.zsh
[[ ! -f /usr/local/Cellar/fzf/0.34.0/shell/key-bindings.zsh ]] || source /usr/local/Cellar/fzf/0.34.0/shell/key-bindings.zsh

# bm - bookmark
bm() {
    pwd >> ~/.shell_bookmarks 
}

# gobm -  go to bookmark
gobm() {
    local dir=$(cat ~/.shell_bookmarks | fzf)
    [[ -d $dir ]] && cd $dir
}

# gossh -  go to ssh
gossh() {
    local ip=$(cat ~/.ssh-ips.sh | fzf)
    ssh $ip
}

# ff - cd to selected directory
ff() {
    local dir=$(fd --type d | fzf)
    [[ -d $dir ]] && cd $dir
}

# fbr - checkout git branch
fbr() {
    local branches branch
    branches=$(git --no-pager branch -vv) &&
        branch=$(echo "$branches" | fzf +m) &&
        git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

# fev - find and edit w/ vim
fev() {
    local file=$(fd -t file | fzf)
    [[ -f $file ]] && vim $file
}


# bind some keys to these funcs
bindkey -s '^f' 'ff\n'
bindkey -s '^b' 'gobm\n'
bindkey -s '^e' 'fev\n'
