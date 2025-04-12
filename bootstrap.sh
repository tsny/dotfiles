echo "Starting setup..."
echo "Creating dirs..."

# Copy over bookmarks only if file doesn't exist
if [ ! -e "$HOME/shell_bookmarks" ]; then
    printf "$HOME/.shell_bookmarks not found! Creating...\n"
    cp -n .shell_bookmarks $HOME
    sed -i "s/\$USER/$(whoami)/g" $HOME/.shell_bookmarks
fi

mkdir -p $HOME/.config/vifm/colors
mkdir -p $HOME/.config/alacritty
mkdir $HOME/dev

cp -R .vim $HOME/.vim

DOTDIR=$HOME/dev/dotfiles/dot

echo "Clearing and Symlinking...\n"

# Move alacritty 
rm -f $HOME/config/alacritty/alacritty.toml
ln -sv ${DOTDIR}/.config/alacritty.toml $HOME/.config/alacritty/alacritty.toml


# Move files that go in $HOME
dotfiles=`find $DOTDIR -type f -name ".*" -exec basename {} \;`
for dotfile in $dotfiles
do
    rm -f $HOME/$dotfile
    ln -sv $DOTDIR/$dotfile $HOME
done

# Autoload vim
# TODO: deprecate
if [ ! -d "$HOME/.vim/autoload" ]; then
    echo "getting vim plug"
    curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# Install oh-my-zsh
if ! echo "$ZSH" | grep -q "oh"; then
    read -p "Do you want to install Oh My Zsh? (y/n): " choice
    if [[ $choice == "y" || $choice == "Y" ]]; then
        sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    fi

    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
else
    echo "oh-my-zsh already installed"
fi


# Install fzf
if [ -d $HOME/.fzf ]; then
    echo "fzf already installed"
    return
else 
    git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
    $HOME/.fzf/install
fi 


echo "Finished setup..."
