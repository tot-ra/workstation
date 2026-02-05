#!/bin/bash
sudo cp ~/bin/vncviewer /usr/local/bin/
sudo chmod +x /usr/local/bin/vncviewer
echo "TigerVNC installed to /usr/local/bin/vncviewer"
vncviewer --version
