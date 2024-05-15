echo "Starting setup..."
echo "Creating dirs..."

# Copy over bookmarks only if file doesn't exist
if [ ! -e "~/.shell_bookmarks" ]; then
    printf "~/.shell_bookmarks not found! Creating...\n"
    cp -n .shell_bookmarks ~
    sed -i "s/\$USER/$(whoami)/g" ~/.shell_bookmarks
fi

mkdir -p ~/.config/vifm/colors
mkdir ~/dev

cp -R .vim ~/.vim

dotDir=~/dev/dotfiles/dot
dotfiles=`find $dotDir -type f -name ".*" -exec basename {} \;`

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

# Install oh-my-zsh
if [[ "$ZSH" != *"oh"* ]]; then
    read -p "Do you want to install Oh My Zsh? (y/n): " choice
    if [[ $choice == "y" || $choice == "Y" ]]; then
        sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    fi
fi

# Install fzf
if [ -d ~/.fzf ]; then
    echo "fzf already installed"
    return
else 
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install
fi 


echo "Finished setup..."
