# Setup fzf
# ---------
if [[ ! "$PATH" == */usr/local/opt/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/usr/local/opt/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/usr/local/opt/fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/usr/local/opt/fzf/shell/key-bindings.bash"

## Helper method to see if app exists


### CUSTOM

echo "Loading custom fzf settings..."

export FZF_DEFAULT_COMMAND="fd --exclude={.git,.idea,.vscode,.sass-cache,node_modules,build,Music,Pictures} --type f"
export FZF_ALT_C_COMMAND="fd --type d"
export FZF_DEFAULT_OPTS="--height 60% --layout=reverse --border"

command_exists () {
    type "$2" &> /dev/null;
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

## go to booksmarks
gg() {
    local dest_dir=$(cat ~/.shell_bookmarks | fzf )
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
    dir="$(
    find "${1:-.}" -type d 2> /dev/null \
        | fzf +m
            )" || return
            cd "$dir" || return
        }

### Bindings

# Bookmarks
bind '"\C-b":"gg\n"'
# VIM
bind '"\C-e":"vim $(fzf)\n"'
# Open Dir
bind '"\C-f":"ff\n"'
