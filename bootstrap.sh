printf "Starting setup...\n"
printf "\nCreating dirs...\n"

touch ~/.shell_bookmarks

mkdir -p ~/.config/vifm/colors
mkdir ~/dev

cp -R .vim ~/.vim

dotDir=~/dev/dotfiles/dot
dotfiles=`find $dotDir -type f -name ".*" -exec basename {} \;`

printf "\nClearing and Symlinking...\n"

for dotfile in $dotfiles
do
    rm ~/$dotfile
    ln -sv $dotDir/$dotfile ~
done

printf "\nFinished setup...\n"
printf "\nRestarting bash...\n"

git config --global user.name "tsny"
git config --global user.email tsny700@gmail.com
git config --global core.editor vim


exec bash
