# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(git zsh-autosuggestions zsh-fzf-history-search)

# bind key to run last command
bindkey -s '^o' '!!\n\n' 
# bind key to go up one dir
bindkey '^ ' autosuggest-accept

source $ZSH/oh-my-zsh.sh
export EDITOR='vim'

source ~/.zsh-vim.zsh
source ~/.alias.sh

# reloads zshrc
alias reload="source ~/.zshrc"

#export GOBIN=/usr/local/bin
export GOPATH=~/dev/go

export PATH=~/dev/go/bin:$PATH
export PATH=~/.local/bin:$PATH
export PATH="~/.gimme/versions/go1.14.6.darwin.amd64/bin:${PATH}"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/.tsny-fzf.zsh ] && source ~/.tsny-fzf.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Load work related zsh
[[ ! -f ~/.work.zsh ]] || source ~/.work.zsh

fpath=(~/.zsh $fpath)

export PATH="$HOME/bin:$PATH"


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/tasnyder/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/tasnyder/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/tasnyder/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/tasnyder/Downloads/google-cloud-sdk/completion.zsh.inc'; fi
