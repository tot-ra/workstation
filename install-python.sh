# For Python
brew install zlib openssl
brew install freetype
brew install pyenv

brew install python@3.11
brew link --force --overwrite python@3.11

export PATH="$HOME/.pyenv/shims:$PATH"
pyenv install --skip-existing 3.7
pyenv install --skip-existing 3.10
pyenv install --skip-existing 3.11
pyenv global 3.11
pyenv global

pip install --upgrade pip
pip install virtualenv

. ~/virtualenv/v1/bin/activate

pip install awscli
