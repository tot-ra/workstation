#!/bin/bash

# Install OpenCode AI coding assistant
echo "Installing OpenCode..."
curl -fsSL https://opencode.ai/install | bash

# Install sag (ElevenLabs TTS tool) using Go
echo "Installing sag..."
go install github.com/steipete/sag/cmd/sag@latest

# Verify installations
if command -v opencode &> /dev/null; then
    echo "OpenCode installed successfully"
    opencode --version
else
    echo "Warning: OpenCode installation may have failed"
fi

if command -v sag &> /dev/null; then
    echo "sag installed successfully"
    sag --version
else
    echo "Warning: sag installation may have failed or ~/go/bin is not in PATH"
    echo "Add this to your ~/.bashrc or ~/.zshrc: export PATH=\$PATH:~/go/bin"
fi
