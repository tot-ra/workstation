#!/bin/bash

set -euo pipefail

BACKUP_DIR="$HOME/workstation-backup-$(date +%Y%m%d-%H%M%S)"
mkdir -p "$BACKUP_DIR"

echo "================================================"
echo "  Workstation Configuration Backup"
echo "================================================"
echo ""
echo "Backup directory: $BACKUP_DIR"
echo ""

backup_if_exists() {
    local source="$1"
    local name="$2"
    
    if [ -e "$source" ]; then
        echo "✓ Backing up $name..."
        cp -r "$source" "$BACKUP_DIR/"
        return 0
    else
        echo "⊘ Skipping $name (not found)"
        return 1
    fi
}

echo "Backing up shell configurations..."
backup_if_exists ~/.zshrc "zsh config"
backup_if_exists ~/.bashrc "bash config"
backup_if_exists ~/.bash_profile "bash profile"
backup_if_exists ~/.profile "profile"

echo ""
echo "Backing up terminal configurations..."
backup_if_exists ~/.tmux.conf "tmux config"
backup_if_exists ~/.config/wezterm "wezterm config"

echo ""
echo "Backing up editor configurations..."
backup_if_exists ~/.config/nvim "neovim config"
backup_if_exists ~/.vimrc "vim config"

echo ""
echo "Backing up git configuration..."
backup_if_exists ~/.gitconfig "git config"
backup_if_exists ~/.gitignore_global "global gitignore"

echo ""
echo "Backing up SSH keys..."
if [ -d ~/.ssh ]; then
    mkdir -p "$BACKUP_DIR/.ssh"
    
    if [ -f ~/.ssh/config ]; then
        cp ~/.ssh/config "$BACKUP_DIR/.ssh/"
        echo "✓ SSH config backed up"
    fi
    
    for key in ~/.ssh/id_*; do
        if [ -f "$key" ]; then
            cp "$key" "$BACKUP_DIR/.ssh/"
            echo "✓ SSH key $(basename $key) backed up"
        fi
    done
fi

echo ""
echo "Backing up development tools configs..."
backup_if_exists ~/.nvm "nvm"
backup_if_exists ~/.npmrc "npm config"
backup_if_exists ~/.yarnrc "yarn config"

echo ""
echo "Backing up application configs..."
backup_if_exists ~/.config/k9s "k9s config"
backup_if_exists ~/.kube/config "kubectl config"

echo ""
echo "Creating manifest..."
cat > "$BACKUP_DIR/MANIFEST.txt" <<EOF
Workstation Backup
==================

Created: $(date)
Hostname: $(hostname)
User: $(whoami)
OS: $(uname -s)

Contents:
EOF

ls -lh "$BACKUP_DIR" >> "$BACKUP_DIR/MANIFEST.txt"

echo ""
echo "================================================"
echo "  Backup Complete!"
echo "================================================"
echo ""
echo "Location: $BACKUP_DIR"
echo "Size: $(du -sh "$BACKUP_DIR" | cut -f1)"
echo ""
echo "To restore, copy files back to their original locations"
echo "or use this as reference for your new setup."
echo ""
