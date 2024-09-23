## 💻 Workstation setup

Yay. You got new machine. Now you need to set it up.
This includes setup scripts for Mac and Ubuntu.

<img width="1920" alt="nvim-tmux" src="https://github.com/user-attachments/assets/9816d8bf-22be-43be-92f4-95d0a402edf6">

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

To install, run: `./install-ui-apps.sh`

Others need manual installation:

- Goland
- Docker4Mac
- [Postman](https://www.postman.com/downloads/)
- [OpenVPN](https://openvpn.net/downloads/openvpn-connect-latest.dmg)
- RealVNC
- Discord
- [GrandPerspective](https://grandperspectiv.sourceforge.net/) to see HDD usage
- [Monocle](https://monokle.io/download) to access k8s logs
- Microsoft TODO

### Fonts

- Install [Jetbrains Mono Nerdfont](https://www.nerdfonts.com/font-downloads) or original [Jetbrains Mono](https://www.jetbrains.com/lp/mono/)
  - Update iTerm and IDEs to use it to see nice icons
  - Use ligatures

### Git settings

```bash
git config --global user.name "Artjom Kurapov"
git config --global user.email "artkurapov@gmail.com"
git config --global pull.rebase false

# generate key for github
ssh-keygen -t rsa -b 4096 -C "artkurapov@gmail.com"
cat ~/.ssh/id_rsa.pub
```

### Installation

```bash
chmod +x install.sh
git clone git@github.com:tot-ra/workstation.git ~/git/workstation
~/git/workstation/install.sh
echo "source ~/git/workstation/mount.sh" >> ~/.zshrc

# link nvim and tmux configs to be linked to github repo
ln -s ~/git/workstation/.tmux.conf ~/.tmux.conf
ln -s ~/git/workstation/.config/nvim ~/.config/nvim

# now add this key to github --> https://github.com/settings/ssh/new
```

### Manual steps after installation

- run `tmux` and run `F1 + I` to install plugins
- run `lazygit` first time to activate
- run nvim and from cmd mode run (where you'll need to install plugins):

```
:Lazy
:LazyExtras
:Copilot auth
:Mason
```

## Custom keyboard shortcuts

- `F1` - tmux
- `F12` - toggle fullscreen (wezterm)

### TMux

Leader (`F1`) and:

- `*` - clears history and terminal
- `?` - show key bindings
- `t` - select session
- `r` - reload config
- `I` - install plugins
- `:` - command mode
- `$` - rename session
- `d` - detach from session

#### Sessions

- `tmux ls` - list sessions
- `tmux new -s my-session` - create session
- `tmux a` - attach to new session
- `tmux a -t my-session` - attach to session by name

#### Windows

- `F1` + `+` - create window
- `F1` + `-` - split window horizontally
- `F1` + `|` - split window vertically
- `Ctrl+Shift-right` - next window
- `Ctrl+Shift-left` - previous window
- `,` - rename window
- `.` - move window

#### Panes

- `Ctrl+arrows` - moves between panes (including within nvim)
- `"` - split window to panes horizontally
- `%` - split window to panes vertically
- `z` - zoom pane (toggle)
- `!` - move pane to own window
- `o` - switch session (interactive with [plugin](https://github.com/omerxx/tmux-sessionx))

### Neovim

- `F3` - find string
- `F4` - find file
- `F11` - toggle DB UI
- `Space` is set as leader
  - `gd` - go to definition
  - `e` - toggle tree view
- `Tab` - accept completion
- `Alt-left/right` - switch between tabs
- `Alt-up` - close tab
- `Alt-down` - pin tab

#### Movement

- `Ctrl+z` - jump to characters (flash plugin)
- `gg` - go to top of the file
  - `G` - go to end of the file
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

#### Code folding

- `za` - Toggle between closing and opening the fold under the cursor.
- `zR` - Open all folds in the current buffer.
- `zM` - Close all folds in the current buffer.

#### Commenting

- `gcc` - comment line

#### Insert mode

- `F2` - search/replace (nvim) with LSP
- `I` - switch to insert mode + go to beginning of the line
- `A` - switch to insert mode + go to end of the line
- `i` - switch to insert mode
- `o` - switch to insert mode + add new line after current one

#### Visual mode

- `y` - copy (yield)
- `p` - paste
- `d` - cut
- `dd` - delete line
- `u` - undo
- `w` - select word

### Git

- `Space gg` - toggle lazygit
