# Wezterm
brew install --cask wezterm
ln -s ~/git/workstation/.config/wezterm ~/.config/wezterm

# Password manager
brew install --cask bitwarden

# visualize keystrokes on the screen for video recordings
brew install --cask keycastr

# clipboard manager
brew install maccy

# Tailscale for connecting own devices in to a private network
brew install tailscale

# NGROK for public tunneling
# ex. ngrok http http://localhost:1234 --host-header="localhost:1234"
brew install ngrok/ngrok/ngrok

# VSCode just in case NVIM is not good enough
brew install --cask visual-studio-code
./install-vscode.sh

# Keka archive manager
brew install --cask keka

# Kap screen recorder
brew install --cask kap

# VLC video player
brew install --cask vlc

# Corporate messenger
brew install --cask slack

# Documenting and note taking
brew install --cask notion
brew install --cask obsidian

# Music player
brew install --cask spotify

# Rectangle window manager
brew install --cask rectangle

# GrandPerspective disk usage visualization
brew install --cask grandperspective

# Install DevToys for conversions
brew install devtoys
open /Applications/DevToys.app

# LM studio
brew install --cask lm-studio
~/.cache/lm-studio/bin/lms bootstrap
lms load lmstudio-community/Meta-Llama-3.1-8B-Instruct-GGUF --identifier llama

brew install --cask goland
