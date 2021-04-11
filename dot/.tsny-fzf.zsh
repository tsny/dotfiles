echo "Loading custom zsh fzf settings..."
export FZF_DEFAULT_COMMAND="fd --exclude={.git,.idea,.vscode,.sass-cache,node_modules,build,Music,Pictures} --type f"
export FZF_ALT_C_COMMAND="fd --type d"
export FZF_DEFAULT_OPTS="--height 60% --layout=reverse --border"

### Bookmark Functions
bm() {
    echo "$curr_dir" >> ~/.shell_bookmarks 
}

### go to booksmarks
gobm() {
    local dest_dir="$(cat ~/.shell_bookmarks | fzf )"
    if [[ $dest_dir != '' ]]; then
        cd "$dest_dir"
    fi
}

# ff - cd to selected directory
ff() {
    local dir
        dir=$(fd --type d | fzf) &&
        cd "$dir"
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
