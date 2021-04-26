# tsny Dotfiles

It ain't much, but it's something

## Prerequisite

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
* fzf-vim

FZF Install
```
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
```

[Powerline 9k](https://gist.github.com/kevin-smets/8568070)
git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
Then edit your ~/.zshrc and set ZSH_THEME="powerlevel10k/powerlevel10k". Once you do so, when you start a new terminal session, the Powerlevel10 configure wizard will be launched to set your prompt, beware, there are many many options!



Vim Plug install on Unix
```
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
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
