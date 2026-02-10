echo "Installing, assuming its x86 64bit ubuntu version"

echo "general update"
sudo apt update
sudo apt upgrade


echo "Installing git large file storage extension"
sudo apt-get install git-lfs -y


echo "Installing nix package manager"
sh <(curl -L https://nixos.org/nix/install) --daemon

# Golang
echo "Installing go"
sudo apt install golang-go -y


## Detect if an Nvidia card is attached, and install the graphics drivers automatically if not already installed
if [[ -n $(lspci | grep -i nvidia) && ! $(command -v nvidia-smi) ]]; then
    echo "Installing Display drivers and any other auto-detected drivers for your hardware"
    sudo add-apt-repository ppa:graphics-drivers/ppa -y
    sudo apt-get update
    sudo ubuntu-drivers autoinstall
fi

echo "Install tailscale"
curl -fsSL https://tailscale.com/install.sh | sh


echo "Installing nvm"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
source ~/.zshrc
nvm install 22

echo "Installing pnpm"
. $HOME/.nvm/nvm.sh && nvm use 22 && npm install -g pnpm


./install-go.sh
./install-go-tools.sh
./install-nvim-tmux.sh
./install-docker-k8s.sh
./install-cli.sh
