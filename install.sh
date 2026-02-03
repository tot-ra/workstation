#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "================================================"
echo "  Workstation Setup - macOS"
echo "================================================"
echo ""

if ! command -v xcode-select &> /dev/null; then
    echo "Installing Xcode Command Line Tools..."
    xcode-select --install
else
    echo "✓ Xcode Command Line Tools already installed"
fi

if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew package manager..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    (
      echo
      echo 'eval "$(/opt/homebrew/bin/brew shellenv)"'
    ) >>/Users/artjom/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    echo "✓ Homebrew already installed"
fi

if ! command -v nix &> /dev/null; then
    echo "Installing Nix package manager..."
    sh <(curl -L https://nixos.org/nix/install)
else
    echo "✓ Nix already installed"
fi

echo ""
echo "Installing core components..."
./install-git.sh
./install-go.sh
./install-cli.sh
./install-nvim-tmux.sh

if ! command -v rustc &> /dev/null; then
    echo "Installing rust for nvim -> mason -> cmake..."
    brew install rust
else
    echo "✓ Rust already installed"
fi

if ! grep -q "source ~/git/workstation/mount.sh" ~/.zshrc 2>/dev/null; then
    echo "Adding mount.sh to .zshrc..."
    echo "source ~/git/workstation/mount.sh" >>~/.zshrc
fi

source ~/.zshrc 2>/dev/null || true

echo ""
echo "Installing additional components..."
./install-db.sh
./install-docker-k8s.sh
./install-media.sh
./install-node.sh
./install-python.sh
./install-ai.sh

echo ""
echo "================================================"
echo "  Installation Complete!"
echo "================================================"
echo ""
echo "Next steps:"
echo "1. Run 'tmux' and press F1+I to install tmux plugins"
echo "2. Run 'nvim' and execute :Lazy, :LazyExtras, :Copilot auth, :Mason"
echo "3. Run 'lazygit' to activate"
echo "4. Configure p10k theme by running 'p10k configure'"
echo ""
echo "Installation logs available at: ~/.workstation-logs/"
echo ""
