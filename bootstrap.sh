echo "Starting setup..."
echo "Creating dirs..."

touch ~/.shell_bookmarks

mkdir -p ~/.config/vifm/colors
mkdir ~/dev

cp -R .vim ~/.vim

dotDir=~/dev/dotfiles/dot
dotfiles=`find $dotDir -type f -name ".*" -exec basename {} \;`

echo "Clearing and Symlinking...\n"

for dotfile in $dotfiles
do
    rm ~/$dotfile
    ln -sv $dotDir/$dotfile ~
done


echo "Initting git"
git config --global user.name "tsny"
git config --global user.email tsny700@gmail.com
git config --global core.editor vim

echo "Finished setup..."
