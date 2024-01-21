echo "Starting setup..."
echo "Creating dirs..."

# Copy over bookmarks only if file doesn't exist
if [ ! -e "~/.shell_bookmarks" ]; then
    cp -n .shell_bookmarks ~
    sed -i "s/\$USER/$(whoami)/g" ~/.shell_bookmarks
    return 1
fi

mkdir -p ~/.config/vifm/colors
mkdir ~/dev

cp -R .vim ~/.vim

dotDir=~/dev/dotfiles/dot
local dotfiles=`find $dotDir -type f -name ".*" -exec basename {} \;`

echo "Clearing and Symlinking...\n"

for dotfile in $dotfiles
do
    rm -f ~/$dotfile
    ln -sv $dotDir/$dotfile ~
done

if [ ! -d "~/.vim/autoload" ]; then
    echo "getting vim plug"
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

echo "Finished setup..."
