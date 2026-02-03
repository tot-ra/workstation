#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOG_DIR="${LOG_DIR:-$HOME/.workstation-logs}"
mkdir -p "$LOG_DIR"
LOG_FILE="${LOG_FILE:-$LOG_DIR/install-$(date +%Y%m%d-%H%M%S).log}"

log() {
    local level="$1"
    shift
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] [$level] $*" | tee -a "$LOG_FILE"
}

log_info() {
    log "INFO" "$@"
}

log_error() {
    log "ERROR" "$@"
}

log_success() {
    log "SUCCESS" "✓ $@"
}

log_skip() {
    log "SKIP" "⊘ $@"
}

trap 'log_error "Error on line $LINENO. Exit code: $?"' ERR

command_exists() {
    command -v "$1" &> /dev/null
}

brew_package_installed() {
    brew list "$1" &> /dev/null
}

brew_cask_installed() {
    brew list --cask "$1" &> /dev/null
}

install_brew_package() {
    local package="$1"
    if brew_package_installed "$package"; then
        log_skip "$package already installed"
    else
        log_info "Installing $package..."
        brew install "$package"
        log_success "$package installed"
    fi
}

install_brew_cask() {
    local package="$1"
    if brew_cask_installed "$package"; then
        log_skip "$package already installed"
    else
        log_info "Installing $package..."
        brew install --cask "$package"
        log_success "$package installed"
    fi
}

install_with_check() {
    local command_name="$1"
    local install_command="$2"
    
    if command_exists "$command_name"; then
        log_skip "$command_name already installed"
    else
        log_info "Installing $command_name..."
        eval "$install_command"
        log_success "$command_name installed"
    fi
}

download_and_verify() {
    local url="$1"
    local expected_sha="$2"
    local output_file="${3:-temp_install.sh}"
    
    log_info "Downloading from $url..."
    curl -fsSL "$url" -o "$output_file"
    
    if [ -n "$expected_sha" ]; then
        log_info "Verifying checksum..."
        echo "$expected_sha  $output_file" | shasum -a 256 -c - || {
            log_error "Checksum verification failed!"
            rm -f "$output_file"
            return 1
        }
        log_success "Checksum verified"
    fi
}

source_versions() {
    if [ -f "$SCRIPT_DIR/versions.env" ]; then
        source "$SCRIPT_DIR/versions.env"
    fi
    if [ -f "$SCRIPT_DIR/checksums.env" ]; then
        source "$SCRIPT_DIR/checksums.env"
    fi
}

log_info "Log file: $LOG_FILE"
