# Setup fzf
# ---------
if [[ ! "$PATH" == */Users/tasnyder/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/Users/tasnyder/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/Users/tasnyder/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/Users/tasnyder/.fzf/shell/key-bindings.bash"
