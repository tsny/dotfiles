# Setup fzf
# ---------
if [[ ! "$PATH" == */Users/taylor.snyder/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/Users/taylor.snyder/.fzf/bin"
fi

source <(fzf --zsh)
