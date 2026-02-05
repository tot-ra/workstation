echo "Installing fzf (fuzzy finder)"
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --bin
echo 'export PATH="$HOME/.fzf/bin:$PATH"' >> ~/.bashrc
echo 'export PATH="$HOME/.fzf/bin:$PATH"' >> ~/.zshrc

echo "Installing htop, an interactive process viewer"
sudo apt install htop -y

echo "Installing bat, a better du to find what is taking disk space"
sudo apt install ncdu -y

echo "Installing bat, a better cat"
sudo apt install bat -y

echo "Install zoxide, a better cd"
sudo apt install zoxide -y

echo "Installing eza, an alternative to ls"
sudo apt install -y gpg
sudo mkdir -p /etc/apt/keyrings
wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
sudo apt update
sudo apt install -y eza

echo "Installing zsh"
sudo apt install zsh

echo "setting zsh to be default"
chsh -s /usr/bin/zsh
zsh --version

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "Restarting zsh"
exec zsh
sudo chsh -s "$(command -v zsh)" "${USER}"

echo "Installing powerlevel10k zsh theme"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
echo "ZSH_THEME='powerlevel10k/powerlevel10k'" >>~/.zshrc

echo "Install zsh-autosuggestions"
sudo git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
sudo git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
echo "plugins=(git zsh-autosuggestions zsh-syntax-highlighting)" | sed '1,/plugins=/ s/.*/&\n\n/' >>~/.zshrc

echo "Installing just, a command runner"
wget -qO - 'https://proget.makedeb.org/debian-feeds/prebuilt-mpr.pub' | gpg --dearmor | sudo tee /usr/share/keyrings/prebuilt-mpr-archive-keyring.gpg 1>/dev/null
echo "deb [arch=all,$(dpkg --print-architecture) signed-by=/usr/share/keyrings/prebuilt-mpr-archive-keyring.gpg] https://proget.makedeb.org prebuilt-mpr $(lsb_release -cs)" | sudo tee /etc/apt/sources.list.d/prebuilt-mpr.list
sudo apt update
sudo apt install just -y

echo "Installing Ghostty (AppImage)"
mkdir -p ~/.local/bin
GHOSTTY_URL=$(curl -s https://api.github.com/repos/pkgforge-dev/ghostty-appimage/releases/latest | grep "browser_download_url.*x86_64.*appimage" | head -n 1 | cut -d '"' -f 4)
curl -L -o ~/.local/bin/ghostty "$GHOSTTY_URL"
chmod +x ~/.local/bin/ghostty

echo "Adding Ghostty desktop entry"
mkdir -p ~/.local/share/applications
cat <<EOF > ~/.local/share/applications/ghostty.desktop
[Desktop Entry]
Name=Ghostty
Comment=Ghostty Terminal Emulator
Exec=$HOME/.local/bin/ghostty
Icon=utilities-terminal
Type=Application
Categories=System;TerminalEmulator;
Terminal=false
StartupNotify=true
EOF
chmod +x ~/.local/share/applications/ghostty.desktop
