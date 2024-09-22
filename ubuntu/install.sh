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

## Docker and kubernetes
echo "Install docker"
sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
apt-cache policy docker-ce
sudo apt install docker-ce -y
sudo systemctl status docker
sudo usermod -aG docker ${USER}

echo "Install docker-compose"
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

echo "Install kubectl"
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
kubectl version --client

echo "Install k9s"
go install github.com/derailed/k9s@latest

echo "Installing dry"
curl -sSf https://moncho.github.io/dry/dryup.sh | sudo sh
sudo chmod 755 /usr/local/bin/dry

## CLI
echo "Installing zsh"
sudo apt install zsh

echo "setting zsh to be default"
chsh -s /usr/bin/zsh
zsh --version

echo "Installing nerd fonts from https://www.nerdfonts.com/font-downloads"
font_url='https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.zip'
font_name=${font_url##*/}; 
wget ${font_url}
unzip ${font_name} -d ~/.fonts
fc-cache -fv

echo "Installing tmux"
sudo apt install tmux -y

echo "Installing latest neovim"
sudo add-apt-repository ppa:neovim-ppa/stable -y
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt update
sudo apt install neovim -y
apt-cache policy neovim

echo "Install lazyvim"
git clone https://github.com/LazyVim/starter ~/.config/nvim
rm -rf ~/.config/nvim/.git


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
