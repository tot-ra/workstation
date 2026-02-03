# Build dependencies for python
sudo apt update || true
sudo apt install -y build-essential libssl-dev zlib1g-dev \
libbz2-dev libreadline-dev libsqlite3-dev curl \
libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev || true

# pyenv
if [ ! -d "$HOME/.pyenv" ]; then
    curl -fsSL https://pyenv.run | bash
else
    echo "pyenv already installed, skipping installation"
fi

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

pyenv install 3.11 -s
pyenv global 3.11

# Source mount.sh if it exists
SCRIPT_DIR=$(dirname "$0")
if [ -f "$SCRIPT_DIR/mount.sh" ]; then
    source "$SCRIPT_DIR/mount.sh"
fi
