echo "Installing go 1.22"
brew install go@1.22
brew link --force --overwrite go@1.22

echo "Installing delve to debug go code"
go install github.com/go-delve/delve/cmd/dlv@latest

echo "Installing just, a make alternative"
brew install just
