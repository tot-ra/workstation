#!/bin/bash

echo "Installing Rust"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source "$HOME/.cargo/env"
echo 'source "$HOME/.cargo/env"' >> ~/.bashrc
echo 'source "$HOME/.cargo/env"' >> ~/.zshrc

echo "Installing libclang-dev (needed for some Rust packages)"
sudo apt install -y libclang-dev

echo "Installing tree-sitter-cli (needed for nvim-treesitter on ARM64/Ubuntu 22.04)"
cargo install tree-sitter-cli

echo "Rust installation complete!"
rustc --version
cargo --version
tree-sitter --version
