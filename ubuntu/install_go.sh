#!/bin/bash
# Script to install Go 1.22.5 (latest stable as of plan)
set -e

GO_VERSION="1.22.5"
GO_ARCH=$(uname -m)
if [ "$GO_ARCH" == "aarch64" ]; then
    GO_ARCHIVE_TYPE="arm64"
elif [ "$GO_ARCH" == "x86_64" ]; then
    GO_ARCHIVE_TYPE="amd64"
else
    echo "Unsupported architecture: ${GO_ARCH}"
    exit 1
fi
GO_ARCHIVE="go${GO_VERSION}.linux-${GO_ARCHIVE_TYPE}.tar.gz"
DOWNLOAD_URL="https://go.dev/dl/${GO_ARCHIVE}"
PROFILE_FILE="${HOME}/.zshrc"
EXPORT_PATH="export PATH=\$PATH:/usr/local/go/bin"

if command -v go &> /dev/null; then
    echo "Go is already installed:"
    go version
    exit 0
fi

echo "--- Go Installation Script ---"
echo "This script will download and install Go to /usr/local/go."
echo "It requires sudo privileges for installation."
echo "1. Downloading Go ${GO_VERSION}..."
wget -q --show-progress ${DOWNLOAD_URL} -O /tmp/${GO_ARCHIVE}

echo "2. Removing previous Go installation (if any) and extracting to /usr/local..."
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf /tmp/${GO_ARCHIVE}

echo "3. Cleaning up..."
rm /tmp/${GO_ARCHIVE}

echo "4. Updating PATH in ${PROFILE_FILE}..."
if ! grep -q "${EXPORT_PATH}" "${PROFILE_FILE}"; then
    echo "" >> "${PROFILE_FILE}"
    echo "# Added by install_go.sh script" >> "${PROFILE_FILE}"
    echo "${EXPORT_PATH}" >> "${PROFILE_FILE}"
    echo "PATH added to ${PROFILE_FILE}."
else
    echo "PATH already set in ${PROFILE_FILE}. Skipping."
fi

echo "--- Installation Complete ---"