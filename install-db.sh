echo "Installing redis"
brew install redis

echo "Installing mysql client for VIM to connect to DBs. Use 8.0 for native password support"
brew install mysql-client@8.0
brew link --overwrite mysql-client@8.0 --force
