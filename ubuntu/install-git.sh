# Install GitHub CLI (gh)
(type -p wget >/dev/null || (sudo apt update && sudo apt-get install wget -y)) \
  && sudo mkdir -p -m 755 /etc/apt/keyrings \
  && out=$(mktemp) \
  && wget -nv -O$out https://cli.github.com/packages/githubcli-archive-keyring.gpg \
  && cat $out | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
  && sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
  && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
  && sudo apt update \
  && sudo apt install gh -y

# Install lazygit
if ! command -v lazygit &> /dev/null; then
  echo "Installing lazygit..."
  
  # Detect architecture
  ARCH=$(uname -m)
  case $ARCH in
    x86_64)
      LAZYGIT_ARCH="Linux_x86_64"
      ;;
    aarch64|arm64)
      LAZYGIT_ARCH="Linux_arm64"
      ;;
    armv7l)
      LAZYGIT_ARCH="Linux_armv7"
      ;;
    *)
      echo "Error: Unsupported architecture: $ARCH"
      exit 1
      ;;
  esac
  
  LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
  
  if [ -z "$LAZYGIT_VERSION" ]; then
    echo "Error: Could not fetch lazygit version"
    exit 1
  fi
  
  echo "Downloading lazygit v${LAZYGIT_VERSION} for ${LAZYGIT_ARCH}..."
  cd /tmp || exit 1
  curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_${LAZYGIT_ARCH}.tar.gz"
  tar xf lazygit.tar.gz lazygit
  sudo install lazygit /usr/local/bin
  rm -f lazygit.tar.gz lazygit
  cd - > /dev/null
  echo "lazygit installed successfully"
else
  echo "lazygit is already installed: $(lazygit --version | head -1)"
fi
