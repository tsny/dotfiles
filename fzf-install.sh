if [ -d ~/.fzf ]; then
    echo "fzf already installed"
    return
fi

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
