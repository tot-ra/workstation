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

### Installation

```bash
chmod +x install.sh
git clone git@github.com:tot-ra/mac-work.git ~/git/mac-work
~/git/mac-work/install.sh
echo "source ~/git/mac-work/mount.sh" >> ~/.zshrc

# link nvim and tmux configs to be linked to github repo
ln -s ~/git/mac-work/.tmux.conf ~/.tmux.conf
ln -s ~/git/mac-work/.config/nvim ~/.config/nvim
```

### Manual steps after installation

#### Mac settings

- Keyboard -> Function keys -> Use F1.. as function keys
  (so that tmux leader key would work fine)

#### Iterm config changes

- Enable clipboard access in General -> Selection -> Applications ... may access clipboard
- Pointer -> remove "Open Context Menu" on right mouse click. This is needed for right-click to work in neovim and tmux

```bash
set -g mouse on
#### Update github settings
git config --global user.name "Artjom Kurapov"
git config --global user.email "artkurapov@gmail.com"
git config --global pull.rebase false

ssh-keygen -t rsa -b 4096 -C "artkurapov@gmail.com"
cat ~/.ssh/id_rsa.pub
# add key to github --> https://github.com/settings/ssh/new
```

## Neovim manual setup

https://www.youtube.com/watch?v=qHsMV5LhOEc
install typescript, go LSP servers

```
:Masonry

# show all characters in markdown
:set conceallevel=0
```

### Neovim cheatsheet

- `Space` is set as leader
- `Space` + `gd` - go to definition

## Movement

- `hjkl` - movement up/down/left/right
- `gg` - go to top of the file
  - `S+g` - go to end of the file
- `20G` - go to line 20
- `5j` - go up 5 lines
  - `5k` - go down 5 lines
- `w` jump to next word
  - `b` jump back to previous word
- `f` - find character

  - `;` next

- `/` - search
  - `n` - next hit

### Insert mode

- `o` - en

### Visual mode

- `y` - copy (yield)
- `p` - paste
- `d` - cut
- `dd` - delete line
- `u` - undo
- `w` - select word

### TMux cheatsheet

- `F3` is set as leader shortcut

Leader (`F3`) and:

- `?` - show key bindings
- `t` - select session
- `r` - reload config
- `I` - install plugins
- `:` - command mode
- `$` - rename session
- `d` - detach from session

## Sessions

- `tmux ls` - list sessions
- `tmux new -s my-session` - create session
- `tmux a` - attach to new session
- `tmux a -t my-session` - attach to session by name

#### Windows

- `c` - create window
- `n` - next window
- `1` - switch to window 1
- `,` - rename window
- `.` - move window

#### Panes

- `"` - split window to panes horizontally
- `%` - split window to panes vertically
- `z` - zoom pane (toggle)
- `(arrows)` - switch to pane
- `!` - move pane to own window
- `o` - switch session (interactive with [plugin](https://github.com/omerxx/tmux-sessionx))
