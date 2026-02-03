#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common-functions.sh"
source_versions

log_info "Starting neovim and tmux installation..."

log_info "Installing neovim..."
install_brew_package "neovim"

if command_exists nvim; then
    git config --global core.editor nvim
    log_success "Set nvim as default git editor"
fi

if [ ! -d "$HOME/.config/nvim" ]; then
    log_info "Installing LazyVim starter config..."
    git clone https://github.com/LazyVim/starter ~/.config/nvim
    rm -rf ~/.config/nvim/.git
    log_success "LazyVim installed"
else
    log_skip "nvim config already exists at ~/.config/nvim"
fi

log_info "Installing tmux..."
install_brew_package "tmux"

log_success "Neovim and tmux installation completed!"
