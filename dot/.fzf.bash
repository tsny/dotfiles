
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
bind -x '"\C-f":"`__fzf_cd__`"'

export FZF_DEFAULT_COMMAND="fd --exclude={.git,.idea,.vscode,.sass-cache,node_modules,build,Music,Pictures} --type f"
export FZF_ALT_C_COMMAND="fd --exclude={.git,.idea,.vscode,.sass-cache,node_modules,build,Music,Pictures} --type d"
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'

