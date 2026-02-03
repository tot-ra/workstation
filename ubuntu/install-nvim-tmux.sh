echo "Installing nerd fonts from https://www.nerdfonts.com/font-downloads"
font_url='https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.zip'
font_name=${font_url##*/}; 
wget ${font_url}
unzip ${font_name} -d ~/.fonts
fc-cache -fv

echo "Installing wezterm"
curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /usr/share/keyrings/wezterm-fury.gpg
echo 'deb [signed-by=/usr/share/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list
sudo apt update
sudo apt install wezterm

echo "Installing latest neovim"
#sudo add-apt-repository ppa:neovim-ppa/stable -y
#sudo add-apt-repository ppa:neovim-ppa/unstable -y
#sudo apt update
#sudo apt install neovim -y
#apt-cache policy neovim

sudo snap install --beta nvim --classic


# in case you don't have sudo:
#cd ~
#curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
#chmod u+x nvim.appimage
# todo add alias for nvim to point to ~/nvim.appimage


echo "Installing tmux"
sudo apt install tmux -y

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

echo "Syncing tmux and nvim configurations"
# Tmux sync
rm -rf ~/.tmux.conf
cp -f ~/git/workstation/.tmux.conf ~/.tmux.conf

# Nvim sync (symlink)
rm -rf ~/.config/nvim
ln -s ~/git/workstation/.config/nvim ~/.config/nvim
