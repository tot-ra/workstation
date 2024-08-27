## 💻 Mac workstation setup
Yay. You got new laptop. Now you need to set it up

- Settings -> Mouse -> disable natural scrolling
- Settings -> Keyboard -> Key Repeat -> Fast
- Settings -> Keyboard -> Delay Until Repeat -> Short
- Settings -> Keyboard -> Text Input -> Disable most things


### Typical apps
- Password manager
- iTerm
- Goland
- Docker4Mac
- [Postman](https://www.postman.com/downloads/)
- [OpenVPN](https://openvpn.net/downloads/openvpn-connect-latest.dmg)
- RealVNC
- [Tailscale](https://tailscale.com/)
- [Rectangle](https://rectangleapp.com/) to resize windows
- [Keka](https://www.keka.io/en/) as archive manager
- [Kap](https://getkap.co/) for video recording as alternative to Quicktime
- [VLC](https://get.videolan.org/vlc/3.0.21/macosx/vlc-3.0.21-arm64.dmg) for playing videos
- VSCode + plugins:
  - Open vscode, click `Command + Shift + P` and install vscode in path to have `code` working in terminal
```bash
./install-vscode.sh
```
- Slack
- Discord
- Notion
- [LM studio](https://lmstudio.ai/) as local alternative to chatgpt
```
brew install --cask lm-studio
~/.cache/lm-studio/bin/lms bootstrap
lms load lmstudio-community/Meta-Llama-3.1-8B-Instruct-GGUF --identifier llama
```

Optional:
- [GrandPerspective](https://grandperspectiv.sourceforge.net/) to see HDD usage
- [Monocle](https://monokle.io/download) to access k8s logs
- Microsoft TODO
- Davinci resolve
- Arduino IDE

### Fonts
- Install [Jetbrains Mono Nerdfont](https://www.nerdfonts.com/font-downloads) or original [Jetbrains Mono](https://www.jetbrains.com/lp/mono/)
  - Update iTerm and IDEs to use it to see nice icons
  - Use ligatures

### Github 
```bash
ssh-keygen -t rsa -b 4096 -C "artkurapov@gmail.com"
cat ~/.ssh/id_rsa.pub
# add key to github --> https://github.com/settings/ssh/new
```


```bash
chmod +x install.sh
git clone git@github.com:tot-ra/mac-work.git ~/git/mac-work
~/git/mac-work/install.sh
echo "source ~/git/mac-work/mount.sh" >> ~/.zshrc
```
