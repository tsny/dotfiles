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

if [ ! -d "~/.vim/autoload" ]; then
    echo "getting vim plug"
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

echo "Finished setup..."
