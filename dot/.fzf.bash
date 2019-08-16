
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

alias ef='vim $(fzf --height 40%)'
alias ffd='__fzf_cd__'

export FZF_DEFAULT_COMMAND="fd --exclude={.git,.idea,.vscode,.sass-cache,node_modules,build,Music,Pictures} --type f"
export FZF_ALT_C_COMMAND="fd --exclude={.git,.idea,.vscode,.sass-cache,node_modules,build,Music,Pictures} --type d"
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'

e() {
  local files

  files="$(
    fasd -fl \
      | fzf \
          --tac \
          --reverse -1 \
          --no-sort \
          --multi \
          --tiebreak=index \
          --bind=ctrl-x:toggle-sort \
          --query "$*" \
      | grep -o "/.*"
  )" || echo 'No file selected'; return

  "${VISUAL:-vim}" "$files"
}

fd() {
  local dir
  dir="$(
    find "${1:-.}" -path '*/\.*' -prune -o -type d -print 2> /dev/null \
      | fzf +m 
  )" || return
  cd "$dir" || return
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

bind '"\C-f":"fd\n"'
