#!/bin/bash

# Install Chromium via Flatpak (works on arm64, unlike Google Chrome)

# Install Flatpak if not present
sudo apt install flatpak -y

# Add Flathub repository
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Install Chromium
flatpak install flathub org.chromium.Chromium -y

# Create wrapper script for MCP automation
mkdir -p ~/.local/bin
cat > ~/.local/bin/chrome-for-mcp << 'EOF'
#!/bin/bash
export DISPLAY=:1.0
exec dbus-launch flatpak run org.chromium.Chromium --remote-debugging-port=9222 "$@"
EOF
chmod +x ~/.local/bin/chrome-for-mcp

echo ""
echo "Chromium installed successfully!"
echo ""
echo "To run Chromium manually:"
echo "  flatpak run org.chromium.Chromium"
echo ""
echo "To run Chromium for MCP automation:"
echo "  ~/.local/bin/chrome-for-mcp"
