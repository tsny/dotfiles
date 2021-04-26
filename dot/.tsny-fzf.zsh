export FZF_DEFAULT_COMMAND="fd --exclude={.git,.idea,.vscode,.sass-cache,node_modules,build,Music,Pictures} --type f"
export FZF_ALT_C_COMMAND="fd --type d"
export FZF_DEFAULT_OPTS="--height 60% --layout=reverse --border"

### Bookmark Functions
bm() {
    pwd >> ~/.shell_bookmarks 
}

### go to booksmarks
gobm() {
    cd $(cat ~/.shell_bookmarks | fzf)
}

# ff - cd to selected directory
ff() {
    cd $(fd --type d | fzf)
}

# fbr - checkout git branch
fbr() {
    local branches branch
    branches=$(git --no-pager branch -vv) &&
        branch=$(echo "$branches" | fzf +m) &&
        git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
    }

# _fda - including hidden directories
fda() {
    local dir
    dir="$(find "${1:-.}" -type d 2> /dev/null \
        | fzf +m)" || return cd "$dir" || return
}

bindkey -s '^f' 'ff\n'
bindkey -s '^b' 'gobm\n'
bindkey -s '^e' 'vim $(fzf)\n'
