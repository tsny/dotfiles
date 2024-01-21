# Setup fzf
# ---------
if [[ ! "$PATH" == */home/tsny/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/tsny/.fzf/bin"
fi

# Auto-completion
# ---------------
source "/home/tsny/.fzf/shell/completion.zsh"

# Key bindings
# ------------
source "/home/tsny/.fzf/shell/key-bindings.zsh"
