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
