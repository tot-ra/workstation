#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common-functions.sh"
source_versions

log_info "Starting Go installation..."

log_info "Installing go ${GO_VERSION}..."
install_brew_package "go@${GO_VERSION}"
brew link --force --overwrite "go@${GO_VERSION}" 2>/dev/null || true

if command_exists go; then
    if ! command_exists dlv; then
        log_info "Installing delve debugger..."
        go install github.com/go-delve/delve/cmd/dlv@latest
        log_success "delve installed"
    else
        log_skip "delve already installed"
    fi
fi

log_info "Installing just (make alternative)..."
install_brew_package "just"

log_success "Go installation completed!"
