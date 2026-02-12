#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common-functions.sh"

log_info "Starting Karabiner-Elements installation..."

# Install Karabiner-Elements via Homebrew
install_brew_cask "karabiner-elements"

# Wait a moment for Karabiner to initialize
sleep 2

# Create Karabiner config directory if it doesn't exist
KARABINER_CONFIG_DIR="$HOME/.config/karabiner"
mkdir -p "$KARABINER_CONFIG_DIR"

# Copy the custom keyboard configuration
REPO_KARABINER_CONFIG="$SCRIPT_DIR/../.config/karabiner/karabiner.json"

if [ -f "$REPO_KARABINER_CONFIG" ]; then
    log_info "Copying Karabiner configuration..."
    cp "$REPO_KARABINER_CONFIG" "$KARABINER_CONFIG_DIR/karabiner.json"
    log_success "Karabiner configuration copied successfully!"
else
    log_warning "Karabiner config not found at $REPO_KARABINER_CONFIG"
    log_info "Creating default configuration with Control+Insert and Shift+Insert mappings..."
    
    cat > "$KARABINER_CONFIG_DIR/karabiner.json" << 'EOF'
{
    "profiles": [
        {
            "complex_modifications": {
                "rules": [
                    {
                        "description": "Control + Insert to Copy, Shift + Insert to Paste",
                        "manipulators": [
                            {
                                "from": {
                                    "key_code": "insert",
                                    "modifiers": {
                                        "mandatory": ["control"]
                                    }
                                },
                                "to": [
                                    {
                                        "key_code": "c",
                                        "modifiers": ["command"]
                                    }
                                ],
                                "type": "basic"
                            },
                            {
                                "from": {
                                    "key_code": "insert",
                                    "modifiers": {
                                        "mandatory": ["shift"]
                                    }
                                },
                                "to": [
                                    {
                                        "key_code": "v",
                                        "modifiers": ["command"]
                                    }
                                ],
                                "type": "basic"
                            }
                        ]
                    }
                ]
            },
            "name": "Default profile",
            "selected": true,
            "virtual_hid_keyboard": { "keyboard_type_v2": "iso" }
        }
    ]
}
EOF
    log_success "Default Karabiner configuration created!"
fi

log_success "Karabiner-Elements installation completed!"
log_info ""
log_info "⚠️  IMPORTANT: Manual steps required"
log_info "1. Open System Settings → Privacy & Security → Accessibility"
log_info "2. Grant permission to Karabiner-Elements and related processes"
log_info "3. You may need to restart your Mac for changes to take effect"
log_info ""
log_info "Keyboard shortcuts configured:"
log_info "  • Control + Insert → Copy (Command + C)"
log_info "  • Shift + Insert → Paste (Command + V)"
log_info ""
log_info "Note: You need a keyboard with an Insert key for these shortcuts to work."
log_info "If using a Mac keyboard without Insert key, you can remap another key in Karabiner."
