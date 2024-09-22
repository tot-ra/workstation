echo "Installing nerd fonts from https://www.nerdfonts.com/font-downloads"
font_url='https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.zip'
font_name=${font_url##*/}; 
wget ${font_url}
unzip ${font_name} -d ~/.fonts
fc-cache -fv
