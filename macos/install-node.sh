#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common-functions.sh"
source_versions

log_info "Starting Node.js installation..."

if [ ! -d "$HOME/.nvm" ]; then
    log_info "Installing nvm ${NVM_VERSION}..."
    curl -o- "https://raw.githubusercontent.com/nvm-sh/nvm/${NVM_VERSION}/install.sh" | bash
    log_success "nvm installed"
    
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
else
    log_skip "nvm already installed"
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
fi

if ! grep -q "npm completion" ~/.bash_profile 2>/dev/null; then
    npm completion >>~/.bash_profile 2>/dev/null || true
fi
if ! grep -q "npm completion" ~/.zshrc 2>/dev/null; then
    npm completion >>~/.zshrc 2>/dev/null || true
fi

log_info "Installing Node versions..."
nvm install ${NODE_VERSION_DEFAULT}
nvm install ${NODE_VERSION_18}
nvm install ${NODE_VERSION_16}

log_info "Setting default Node version to ${NODE_VERSION_DEFAULT}..."
nvm alias default ${NODE_VERSION_DEFAULT}

log_info "Installing pnpm..."
install_brew_package "pnpm"

log_success "Node.js installation completed!"