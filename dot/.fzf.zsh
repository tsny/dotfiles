# Setup fzf
# ---------
if [[ ! "$PATH" == */home/tsny/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/tsny/.fzf/bin"
fi

# source <(fzf --zsh)
