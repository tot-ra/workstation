sudo rm -R /usr/local/go
# wget -c https://go.dev/dl/go1.20.14.linux-arm64.tar.gz
wget -c https://go.dev/dl/go1.23.1.linux-arm64.tar.gz

sudo tar -C /usr/local/ -xzf go1.23.1.linux-arm64.tar.gz
#sudo tar -C /usr/local/ -xzf go1.20.14.linux-arm64.tar.gz
unlink /usr/bin/go
sudo ln -s /usr/local/go/bin/go /usr/bin/go
go version
