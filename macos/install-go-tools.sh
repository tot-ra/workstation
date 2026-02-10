#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common-functions.sh"

log_info "Starting Go CLI tools installation..."

# Ensure Go is installed
if ! command_exists go; then
    log_error "Go is not installed. Please run install-go.sh first."
    exit 1
fi

log_info "Go version: $(go version)"

# Ensure ~/go/bin is in PATH
GOBIN_PATH='export PATH="$HOME/go/bin:$PATH"'
PROFILE_FILE="$HOME/.zshrc"

if ! grep -q "go/bin" "$PROFILE_FILE" 2>/dev/null; then
    log_info "Adding ~/go/bin to PATH in $PROFILE_FILE..."
    echo "" >> "$PROFILE_FILE"
    echo "# Added by install-go-tools.sh" >> "$PROFILE_FILE"
    echo "$GOBIN_PATH" >> "$PROFILE_FILE"
    log_success "Added ~/go/bin to PATH"
else
    log_skip "~/go/bin already in PATH"
fi

# Install lazysql - TUI for SQL databases
if ! command_exists lazysql; then
    log_info "Installing lazysql (SQL database TUI)..."
    go install github.com/jorgerojas26/lazysql@latest
    log_success "lazysql installed"
else
    log_skip "lazysql already installed"
fi

# Install air - live reload for Go apps
if ! command_exists air; then
    log_info "Installing air (live reload for Go)..."
    go install github.com/cosmtrek/air@latest
    log_success "air installed"
else
    log_skip "air already installed"
fi

# Install lazygit - TUI for Git
if ! command_exists lazygit; then
    log_info "Installing lazygit (Git TUI)..."
    go install github.com/jesseduffield/lazygit@latest
    log_success "lazygit installed"
else
    log_skip "lazygit already installed"
fi

# Install lazydocker - TUI for Docker
if ! command_exists lazydocker; then
    log_info "Installing lazydocker (Docker TUI)..."
    go install github.com/jesseduffield/lazydocker@latest
    log_success "lazydocker installed"
else
    log_skip "lazydocker already installed"
fi

# Install glow - Markdown renderer
if ! command_exists glow; then
    log_info "Installing glow (Markdown renderer)..."
    go install github.com/charmbracelet/glow@latest
    log_success "glow installed"
else
    log_skip "glow already installed"
fi

# Install fx - JSON viewer
if ! command_exists fx; then
    log_info "Installing fx (interactive JSON viewer)..."
    go install github.com/antonmedv/fx@latest
    log_success "fx installed"
else
    log_skip "fx already installed"
fi

log_success "Go CLI tools installation completed!"
echo ""
echo "Installed tools in ~/go/bin:"
ls -lh ~/go/bin/ 2>/dev/null || echo "No tools found"
echo ""
echo "To use these tools immediately, run:"
echo "  source ~/.zshrc"
echo ""
