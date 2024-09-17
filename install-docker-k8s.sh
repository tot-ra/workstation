## Docker and kubernetes
echo "Install kubectl"
brew install kubectl

echo "Install k9s"
brew install derailed/k9s/k9s
export KUBE_EDITOR=nvim

echo "Installing dry"
curl -sSf https://moncho.github.io/dry/dryup.sh | sudo sh
sudo chmod 755 /usr/local/bin/dry

echo "Install lazydocker, alternative to dry"
brew install jesseduffield/lazydocker/lazydocker
brew install lazydocker
