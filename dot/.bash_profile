if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi

export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"
export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/lib/pkgconfig

# Configuration for Python, PIP, OpenSSL to trust the PayPal Proxy Certificates
export REQUESTS_CA_BUNDLE='/usr/local/etc/openssl/certs/combined_cacerts.pem'
export SSL_CERT_FILE='/usr/local/etc/openssl/certs/combined_cacerts.pem'

# Configuration for node to trust the PayPal Proxy Certificates
export NODE_EXTRA_CA_CERTS='/usr/local/etc/openssl/certs/paypal_proxy_cacerts.pem'
. "$HOME/.cargo/env"
