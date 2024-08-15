echo "Installing nvm / node env"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash
npm completion >> ~/.bash_profile
npm completion >> ~/.zshrc
