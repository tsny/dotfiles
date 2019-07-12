printf "Starting setup...\n"

printf "\nCreating dirs...\n"

mkdir -p ~/.config/vifm/colors
mkdir ~/dev
mkdir ~/screenshots

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

bash
