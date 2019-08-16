# Setup fzf
# ---------
if [[ ! "$PATH" == */home/tsny/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/tsny/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/tsny/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/tsny/.fzf/shell/key-bindings.bash"
