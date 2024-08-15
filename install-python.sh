# For Python
brew install zlib openssl
brew install freetype
brew install pyenv
export PATH="$HOME/.pyenv/shims:$PATH"
pyenv install --skip-existing 3.11
pyenv global 3.11
pyenv global


pip install --upgrade pip
pip install virtualenv

. ~/virtualenv/v1/bin/activate
