if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi

export PATH="$HOME/.cargo/bin:$PATH"
export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"
export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/lib/pkgconfig
