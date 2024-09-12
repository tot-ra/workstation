# Iterm2
brew install --cask iterm2

# Password manager
brew install --cask bitwarden

# visualize keystrokes on the screen for video recordings
brew install --cask keycastr

# clipboard manager
brew install maccy

# Tailscale
brew install tailscale

# VSCode just in case NVIM is not good enough
brew install --cask visual-studio-code
./install-vscode.sh

# Keka archive manager
brew install --cask keka

# Kap screen recorder
brew install --cask kap

# VLC video player
brew install --cask vlc

# Rectangle window manager
brew install --cask rectangle

# Install DevToys for conversions
brew install devtoys
open /Applications/DevToys.app

# LM studio
brew install --cask lm-studio
~/.cache/lm-studio/bin/lms bootstrap
lms load lmstudio-community/Meta-Llama-3.1-8B-Instruct-GGUF --identifier llama
