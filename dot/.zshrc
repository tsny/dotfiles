# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

plugins=(git)

# show which vim mode we are in
precmd() {
  RPROMPT=""
}
zle-keymap-select() {
  RPROMPT=""
  [[ $KEYMAP = vicmd ]] && RPROMPT="(COMMAND MODE)"
  () { return $__prompt_status }
  zle reset-prompt
}

source $ZSH/oh-my-zsh.sh
export EDITOR='vim'

source ~/zsh-vim.zsh
source ~/alias.sh

export GOPATH=~/dev/go

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
