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

echo "Installing rust for nvim -> mason -> cmake"
brew install rust

echo "Mount mount.sh"
echo "source ~/git/mac-work/mount.sh" >>~/.zshrc
source ~/.zshrc

./install-db.sh
./install-docker-k8s.sh
./install-media.sh
./install-node.sh
./install-python.sh
