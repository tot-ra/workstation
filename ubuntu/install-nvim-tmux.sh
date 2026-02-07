echo "Installing nerd fonts from https://www.nerdfonts.com/font-downloads"
font_url='https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.zip'
font_name=${font_url##*/}; 
wget ${font_url}
unzip ${font_name} -d ~/.fonts
fc-cache -fv

echo "Installing wezterm"
curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /usr/share/keyrings/wezterm-fury.gpg
echo 'deb [signed-by=/usr/share/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list
sudo apt update
sudo apt install wezterm

echo "Installing wezterm terminfo (fixes 'missing or unsuitable terminal' in tmux)"
tempfile=$(mktemp) && curl -o $tempfile https://raw.githubusercontent.com/wez/wezterm/main/termwiz/data/wezterm.terminfo && tic -x -o ~/.terminfo $tempfile && rm $tempfile

echo "Installing stable neovim v0.11.6"
# Download pre-built binary from GitHub releases (stable version)
# This avoids issues with snap/unstable versions that may crash with LazyVim
NVIM_VERSION="0.11.6"
NVIM_DIR="$HOME/.local/bin/nvim-stable"
NVIM_BIN="$HOME/.local/bin/nvim"

mkdir -p "$NVIM_DIR"
cd "$NVIM_DIR"

# Detect architecture
ARCH=$(uname -m)
if [ "$ARCH" = "aarch64" ] || [ "$ARCH" = "arm64" ]; then
    NVIM_ARCH="arm64"
elif [ "$ARCH" = "x86_64" ]; then
    NVIM_ARCH="x86_64"
else
    echo "Unsupported architecture: $ARCH"
    exit 1
fi

# Download and extract
echo "Downloading nvim v${NVIM_VERSION} for ${NVIM_ARCH}..."
wget -q "https://github.com/neovim/neovim/releases/download/v${NVIM_VERSION}/nvim-linux-${NVIM_ARCH}.tar.gz" -O nvim.tar.gz
tar -xzf nvim.tar.gz
rm nvim.tar.gz

# Create symlink
ln -sf "$NVIM_DIR/nvim-linux-${NVIM_ARCH}/bin/nvim" "$NVIM_BIN"

echo "Nvim v${NVIM_VERSION} installed to $NVIM_BIN"
$NVIM_BIN --version | head -1


echo "Installing tmux"
sudo apt install tmux -y

echo "Installing xclip for clipboard support"
sudo apt install xclip -y

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Sync configurations via symlinks
./symlinks.sh
