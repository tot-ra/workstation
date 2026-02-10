#!/bin/bash
# Script to install useful Go CLI tools
set -e

echo "--- Installing Go CLI Tools ---"

# Ensure Go is installed
if ! command -v go &> /dev/null; then
    echo "Error: Go is not installed. Please run install_go.sh first."
    exit 1
fi

echo "Go version: $(go version)"

# Ensure ~/go/bin is in PATH
GOBIN_PATH="export PATH=\"\$HOME/go/bin:\$PATH\""
PROFILE_FILE="${HOME}/.zshrc"

if ! grep -q "go/bin" "${PROFILE_FILE}"; then
    echo "" >> "${PROFILE_FILE}"
    echo "# Added by install-go-tools.sh" >> "${PROFILE_FILE}"
    echo "${GOBIN_PATH}" >> "${PROFILE_FILE}"
    echo "Added ~/go/bin to PATH in ${PROFILE_FILE}"
else
    echo "~/go/bin already in PATH"
fi

# Install lazysql - TUI for SQL databases
echo "Installing lazysql (SQL database TUI)..."
go install github.com/jorgerojas26/lazysql@latest

# Install air - live reload for Go apps
echo "Installing air (live reload for Go)..."
go install github.com/cosmtrek/air@latest

# Install lazygit - TUI for Git (if not already installed globally)
if ! command -v lazygit &> /dev/null; then
    echo "Installing lazygit (Git TUI)..."
    go install github.com/jesseduffield/lazygit@latest
else
    echo "lazygit already installed globally, skipping"
fi

# Install lazydocker - TUI for Docker
echo "Installing lazydocker (Docker TUI)..."
go install github.com/jesseduffield/lazydocker@latest

# Install glow - Markdown renderer
echo "Installing glow (Markdown renderer)..."
go install github.com/charmbracelet/glow@latest

# Install fx - JSON viewer
echo "Installing fx (interactive JSON viewer)..."
go install github.com/antonmedv/fx@latest

echo ""
echo "--- Installation Complete ---"
echo "Installed tools:"
ls -lh ~/go/bin/

echo ""
echo "To use these tools immediately, run:"
echo "  source ~/.zshrc"
echo ""
echo "Or open a new terminal window."
