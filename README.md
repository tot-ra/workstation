## 💻 Mac workstation setup

Yay. You got new laptop. Now you need to set it up

#### Mac settings

- Keyboard -> Input Sources -> change language to CMD + Space
- Keyboard -> Spotlight - change to CMD + Shift + Space
- Keyboard -> Function keys -> Turn on "Use F1.. as function keys"
- Keyboard -> Mission control -> turn off `Mission Control` and `Application windows`, `Show Desktop`
  - change `move left/right a space` to use CMD instead of CTRL
    (so that tmux leader key would work fine)
- Mouse -> disable natural scrolling
- Keyboard -> Key Repeat -> Fast
- Keyboard -> Delay Until Repeat -> Short
- Keyboard -> Text Input -> Disable most things
- Keyboard -> Accessibility -> Disable VoiceOver

### Apps

```bash
./install-ui-apps.sh
``

- Goland
- Docker4Mac
- [Postman](https://www.postman.com/downloads/)
- [OpenVPN](https://openvpn.net/downloads/openvpn-connect-latest.dmg)
- RealVNC
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

- Install [Jetbrains Mono Nerdfont](https://www.nerdfonts.com/font-downloads) or original [Jetbrains Mono](https://www.jetbrains.com/lp/mono/)
  - Update iTerm and IDEs to use it to see nice icons
  - Use ligatures

### Git settings

```

git config --global user.name "Artjom Kurapov"
git config --global user.email "artkurapov@gmail.com"
git config --global pull.rebase false

# generate key for github

ssh-keygen -t rsa -b 4096 -C "artkurapov@gmail.com"
cat ~/.ssh/id_rsa.pub

- add key to github --> https://github.com/settings/ssh/new
- run `lazygit` first time to activate
- see https://youtu.be/CPLdltN7wgE for more info

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

#### Iterm config changes

- Enable clipboard access in General -> Selection -> Applications ... may access clipboard
- Pointer -> remove "Open Context Menu" on right mouse click. This is needed for right-click to work in neovim and tmux

```bash
set -g mouse on


```

## Neovim manual setup

https://www.youtube.com/watch?v=qHsMV5LhOEc

You need to install LSP servers for languages you want, authenticate github copilot etc.

```
:Lazy
:LazyExtras
:Copilot auth
:Mason
```

### Neovim cheatsheet

- `Space` is set as leader
  - `gd` - go to definition
  - `e` - toggle tree view
- `Ctrl+h` - switch to neotree
- `Ctrl+l` - switch to code
- `[b` - prev tab
  - `]b` - next tab

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
- `f(` - jump to next bracket

### Code folding

- `za` - Toggle between closing and opening the fold under the cursor.
- `zR` - Open all folds in the current buffer.
- `zM` - Close all folds in the current buffer.

### Insert mode

- `I` - switch to insert mode + go to beginning of the line
- `A` - switch to insert mode + go to end of the line
- `i` - switch to insert mode
- `o` - switch to insert mode + add new line after current one

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
