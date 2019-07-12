# My Bash Stuff

It ain't much, but it's somethin'.

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
sh tsny.sh
```

## TODO

1. Move base installation to home dir  
2. Make bootstrap load files in folders

## Total Commander

The Total Commander rc is not really something that I can move across different systems because the 
folder structure in each Windows env is not going to be the same, but this is these are the vim like 
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
```
