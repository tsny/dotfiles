# tsny Dotfiles

It ain't much, but it's something

## Prerequisite and Notes

I use zsh so older stuff may not work well with bash.
I also move between Mac and WSL so some stuff may not work well out-of-the-box

As of right now, I kind of hardcode my dotfiles folder to be in `~/dev/dotfiles`
This isn't really how many people do it but as of right now that's just how it is

## Installation

Full install
```
git clone https://github.com/tsny/dotfiles.git ~/dev/dotfiles;
cd ~/dev/dotfiles;
sh bootstrap.sh;
```

Clone the repo
```
git clone https://github.com/tsny/dotfiles.git ~/dev/dotfiles
```

Run this 

```
sh bootstrap.sh
```

Other stuff:

1. Make an ssh key
```
ssh-keygen -t rsa -b 2048 -C "your_email@example.com"
```

## Plugins

### [fzf](https://github.com/junegunn/fzf)
Fuzzy finder. Literally the best application ever written

```
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
```

Either
`brew install fd`
or (installs and makes link to fd)
`sudo apt-get install fd-find; mkdir ~/.local; mkdir ~/.local/bin; ln -s $(which fdfind) ~/.local/bin/fd`

Ensure your path has `~/.local/bin` in it 

Note 2024: Had to do this on Ubuntu: 
```
# Download the binary
wget https://github.com/sharkdp/fd/releases/download/v8.2.1/fd-musl_8.2.1_amd64.deb

# Install the downloaded package
sudo dpkg -i fd-musl_8.2.1_amd64.deb
```

### [Gruvbox](https://github.com/gruvbox-community/gruvbox/wiki/Installation)

Nice theme for Vim

### [Tmux manager](https://github.com/tmux-plugins/tpm)

Plugin manager for tmux

### [Powerline](https://gist.github.com/kevin-smets/8568070)

`git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k`

Edit your ~/.zshrc and set `ZSH_THEME="powerlevel10k/powerlevel10k"`
Once you do so, when you start a new terminal session, the Powerlevel10 configure wizard will be launched to set your prompt, beware, there are many many options!

### [ZSH Autocomplete](https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md)
Self-explanatory

```
# zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# Install oh my zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### [Vim Plug](https://github.com/junegunn/vim-plug)
Package manager for Vim extensions

```
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

### [Delta](https://github.com/dandavison/delta)
Better diff for git
`brew install git-delta`

Example .gitconfig
```
[core]
    editor = VIM
    pager = delta
[interactive]
    diffFilter = delta --color-only
[delta]
    features = side-by-side line-numbers decorations
    whitespace-error-style = 22 reverse
[delta "decorations"]
    commit-decoration-style = bold yellow box ul
    file-style = bold yellow ul
    file-decoration-style = none
```

## Total Commander

The Total Commander config is not really something that I can move across different systems because the 
folder structure in each Windows environment is not going to be the same, but this is these are the vim like 
shortcuts that go in the `wincmd.ini`

```
[Shortcuts]
T=cm_Reverse
H=cm_GoToParent
L=cm_GoToDir
OEM_US/?=cm_ShowQuickSearch
I=cm_EditExistingFile
C+P=cm_CopySrcPathToClip
OEM_+=cm_MatchSrc
C+R=cm_RenameOnly
C+M=cm_RenMov
C+F=cm_SearchFor
C+N=cm_EditNewFile
BACK=cm_GotoPreviousDir
```
