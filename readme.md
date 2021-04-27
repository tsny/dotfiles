# tsny Dotfiles

It ain't much, but it's something

## Prerequisite and Notes

I use zsh so older stuff may not work well with bash.
I also move between Mac and WSL so some stuff may not work well out-of-the-box

As of right now, I kind of hardcode my dotfiles folder to be in `~/dev/dotfiles`
This isn't really how many people do it but as of right now that's just how it is

## Installation

Clone the repo
```
git clone https://github.com/tsny/dotfiles.git ~/dev/dotfiles
```

Run this to create folders and symlink the stuff

```
sh bootstrap.sh
```

## TODO

- Make a .conf folder that should house most of our supplementary config files like
(alias.sh, fzf.sh, etc)

## Plugins

### [fzf](https://github.com/junegunn/fzf)
Fuzzy finder. Literally the best application ever written

```
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
```

### [Powerline](https://gist.github.com/kevin-smets/8568070)

`git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k`

Edit your ~/.zshrc and set `ZSH_THEME="powerlevel10k/powerlevel10k"`
Once you do so, when you start a new terminal session, the Powerlevel10 configure wizard will be launched to set your prompt, beware, there are many many options!

### [ZSH Autocomplete](https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md)
Self-explanatory

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
