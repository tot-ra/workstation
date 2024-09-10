echo "Install neovim"
brew install neovim
git config --global core.editor nvim

echo "Install lazyvim"
git clone https://github.com/LazyVim/starter ~/.config/nvim
rm -rf ~/.config/nvim/.git

echo "Install tmux"
brew install tmux
