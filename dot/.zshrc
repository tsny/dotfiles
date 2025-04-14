#zmodload zsh/zprof

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="powerlevel10k/powerlevel10k"
# ZSH_THEME="cloud"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions zsh-fzf-history-search kubectl)

source $ZSH/oh-my-zsh.sh

# User configuration
export EDITOR='vim'

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

# bind key to run last command
bindkey -s '^o' '!!\n\n' 
# bind key to go up one dir
bindkey '^ ' autosuggest-accept

source ~/.zsh-vim.zsh
source ~/.alias.sh

# reloads zshrc
# alias reload="source ~/.zshrc"
alias reload='exec "$SHELL"'

vi() {
  $EDITOR $@
}

export PATH=~/dev/go/bin:$PATH


if [[ ! "$PATH" == */Users/$USER/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/Users/$USER/.fzf/bin"
  source <(fzf --zsh)
fi

[ -f ~/.tsny-fzf.zsh ] && source ~/.tsny-fzf.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Load work related zsh
[[ ! -f ~/.work.zsh ]] || source ~/.work.zsh


function update_alacritty_theme() {
  local alac_config="$HOME/.config/alacritty/alacritty.toml"
  local light_theme='"~/.config/alacritty/catppuccin-latte.toml"'
  local dark_theme='"~/.config/alacritty/catppuccin-mocha.toml"'
  local tmp_file="$(mktemp)"

  local appearance=$(defaults read -g AppleInterfaceStyle 2>/dev/null)

  if [[ "$appearance" == "Dark" ]]; then
    sed "s|$light_theme|$dark_theme|g" "$alac_config" > "$tmp_file"
  else
    sed "s|$dark_theme|$light_theme|g" "$alac_config" > "$tmp_file"
  fi

  # Overwrite the symlink target instead of the symlink
  cp "$tmp_file" "$(realpath "$alac_config")"
  rm "$tmp_file"
}

update_alacritty_theme
