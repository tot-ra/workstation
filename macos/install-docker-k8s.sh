#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common-functions.sh"

log_info "Starting Docker and Kubernetes tools installation..."

log_info "Installing kubectl..."
install_brew_package "kubectl"

log_info "Installing OrbStack (Docker alternative)..."
install_brew_cask "orbstack"

log_info "Installing k9s..."
install_brew_package "derailed/k9s/k9s"

if ! grep -q "KUBE_EDITOR=nvim" ~/.zshrc 2>/dev/null; then
    echo "export KUBE_EDITOR=nvim" >> ~/.zshrc
    log_info "Set KUBE_EDITOR=nvim in .zshrc"
fi

if ! command_exists dry; then
    log_info "Installing dry..."
    curl -sSf https://moncho.github.io/dry/dryup.sh | sudo sh
    sudo chmod 755 /usr/local/bin/dry 2>/dev/null || true
    log_success "dry installed"
else
    log_skip "dry already installed"
fi

log_info "Installing lazydocker..."
install_brew_package "jesseduffield/lazydocker/lazydocker"

log_info "Installing helm..."
install_brew_package "helm"

log_success "Docker and Kubernetes tools installation completed!"

