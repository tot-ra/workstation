echo "Update xcode"
xcode-select --install

echo "Installing brew package manager"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
(
  echo
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"'
) >>/Users/artjom/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

# Nix
echo "Installing nix package manager"
sh <(curl -L https://nixos.org/nix/install)

./install-git.sh
./install-go.sh
./install-cli.sh
./install-nvim-tmux.sh

echo "Mount mount.sh"
echo "source ~/git/mac-work/mount.sh" >>~/.zshrc
source ~/.zshrc

## Docker and kubernetes
echo "Install kubectl"
brew install kubectl

echo "Install k9s"
brew install derailed/k9s/k9s
export KUBE_EDITOR=nvim

echo "Installing dry"
curl -sSf https://moncho.github.io/dry/dryup.sh | sudo sh
sudo chmod 755 /usr/local/bin/dry

echo "Installing redis"
brew install redis

./install-node.sh
./install-python.sh
./install-ui-apps.sh
