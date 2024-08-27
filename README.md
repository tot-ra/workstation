## 💻 Mac workstation setup
Yay. You got new laptop. Now you need to set it up

### Typical apps
- iTerm
- Goland
- Docker4Mac
- [Postman](https://www.postman.com/downloads/)
- [OpenVPN](https://openvpn.net/downloads/openvpn-connect-latest.dmg)
- RealVNC
- NordPass password manager
- [Tailscale](https://tailscale.com/)
- [Rectangle](https://rectangleapp.com/) to resize windows
- [LM studio](https://lmstudio.ai/) as local alternative to chatgpt
- [Keka](https://www.keka.io/en/) as archive manager
- [Kap](https://getkap.co/) for video recording as alternative to Quicktime
- VSCode + plugins:
  - Open vscode, click `Command + Shift + P` and install vscode in path to have `code` working in terminal
```bash
./install-vscode.sh
```
- Slack
- Discord
- Notion

Optional:
- [GrandPerspective](https://grandperspectiv.sourceforge.net/) to see HDD usage
- [Monocle](https://monokle.io/download) to access k8s logs
- Microsoft TODO
- Davinci resolve
- Arduino IDE

### Fonts
- Install [Jetbrains Mono](https://www.jetbrains.com/lp/mono/)
  - Update iTerm to use it

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
