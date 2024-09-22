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

## CLI
echo "Installing zsh"
sudo apt install zsh

echo "setting zsh to be default"
chsh -s /usr/bin/zsh
zsh --version

echo "Installing eza, an alternative to ls"
sudo apt install -y gpg
sudo mkdir -p /etc/apt/keyrings
wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
sudo apt update
sudo apt install -y eza


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
nvm install 20


echo "Installing bat"
sudo apt install bat -y



sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "Restarting zsh"
exec zsh
sudo chsh -s "$(command -v zsh)" "${USER}"

echo "Installing powerlevel10k zsh theme"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
echo "ZSH_THEME='powerlevel10k/powerlevel10k'" >> ~/.zshrc

echo "Install zsh-autosuggestions"
sudo git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
sudo git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
echo "plugins=(git zsh-autosuggestions zsh-syntax-highlighting)" | sed '1,/plugins=/ s/.*/&\n\n/' >> ~/.zshrc
