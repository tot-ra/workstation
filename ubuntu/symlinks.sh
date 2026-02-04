#!/bin/bash
echo "Creating symlinks for configuration files"

# Tmux config (symlink)
rm -rf ~/.tmux.conf
ln -s ~/git/workstation/.tmux.conf ~/.tmux.conf

# Nvim config (symlink)
rm -rf ~/.config/nvim
ln -s ~/git/workstation/.config/nvim ~/.config/nvim

# Opencode config (symlink)
rm -rf ~/.config/opencode
ln -s ~/git/workstation/.config/opencode ~/.config/opencode

# Google Calendar MCP credentials (symlink)
ln -sf ~/git/mind/google_calendar_client_secret.json ~/git/workstation/google_calendar_client_secret.json

echo "Symlinks created successfully"
