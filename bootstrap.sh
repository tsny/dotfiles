DOTDIR=$HOME/dev/dotfiles/dot
CONFIG_DIR=$HOME/.config

link_config_item() {
    # Merge directories that already exist so nested config (for example,
    # nvim/lua) is linked without replacing local files.
    if [ -d "$1" ] && [ -d "$2" ] && [ ! -L "$2" ]; then
        for config_item in "$1"/* "$1"/.[!.]* "$1"/..?*; do
            if [ ! -e "$config_item" ] && [ ! -L "$config_item" ]; then
                continue
            fi
            link_config_item "$config_item" "$2/$(basename "$config_item")"
        done
    elif [ ! -e "$2" ] && [ ! -L "$2" ]; then
        mkdir -p "$(dirname "$2")"
        ln -sv "$1" "$2"
    else
        echo "  skip: ${2#"$CONFIG_DIR"/} already exists"
    fi
}

relink_config() {
    echo "Relinking missing .config symlinks..."
    mkdir -p "$CONFIG_DIR"
    for item in "$DOTDIR/.config"/*; do
        name=$(basename "$item")
        if [ "$name" = "alacritty.toml" ]; then
            target="$CONFIG_DIR/alacritty/alacritty.toml"
        else
            target="$CONFIG_DIR/$name"
        fi
        link_config_item "$item" "$target"
    done
    echo "Done."
}

case "${1:-}" in
    relink) relink_config; exit 0 ;;
esac

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

echo "Clearing and Symlinking...\n"

# Move alacritty 
rm -f $CONFIG_DIR/alacritty/alacritty.toml
ln -sv ${DOTDIR}/.config/alacritty.toml $CONFIG_DIR/alacritty/alacritty.toml

# Link application config, including Neovim's init.lua and lua modules.
relink_config


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

# nvim-treesitter's current installer builds parsers with the Tree-sitter CLI.
if ! command -v tree-sitter >/dev/null 2>&1; then
    echo "Installing tree-sitter CLI for Neovim..."
    if command -v brew >/dev/null 2>&1; then
        brew install tree-sitter-cli
    elif command -v npm >/dev/null 2>&1; then
        npm install -g tree-sitter-cli
    else
        echo "Unable to install tree-sitter CLI: Homebrew or npm is required." >&2
    fi
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
else 
    git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
    $HOME/.fzf/install
fi 


echo "Finished setup..."
