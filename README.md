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

#### Window management shortcuts (with Rectangle)

- <kbd>§</kbd> - center window
- <kbd>Shift</kbd> <kbd>§</kbd> - restore window position
- <kbd>Shift</kbd> <kbd>+</kbd> - increase window
- <kbd>Shift</kbd> <kbd>-</kbd> - decrease window
- <kbd>Shift</kbd> <kbd>F1</kbd> - move window left-top
- <kbd>Shift</kbd> <kbd>F2</kbd> - move window right-top
- <kbd>Shift</kbd> <kbd>F3</kbd> - move window left-bottom
- <kbd>Shift</kbd> <kbd>F4</kbd> - move window right-bottom

#### Warp terminal shortcuts

- <kbd>Cmd</kbd> <kbd>+</kbd> - increase font
- <kbd>Cmd</kbd> <kbd>-</kbd> - decrease font
- <kbd>Cmd</kbd> <kbd>t</kbd> - open tab
- <kbd>Cmd</kbd> <kbd>n</kbd> - open new window

### Apps

To install, run: `./install-ui-apps.sh`

Others need manual installation:

- Goland
- Docker4Mac
- [Postman](https://www.postman.com/downloads/)
- [OpenVPN](https://openvpn.net/downloads/openvpn-connect-latest.dmg)
- RealVNC
- Discord
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

- run `tmux` and run <kbd>F1</kbd> <kbd>I</kbd> to install plugins
- run `lazygit` first time to activate
- run nvim and from cmd mode run (where you'll need to install plugins):

```
:Lazy
:LazyExtras
:Copilot auth
:Mason
```

## Custom keyboard shortcuts

- <kbd>F1</kbd> - tmux
- <kbd>F12</kbd> - toggle fullscreen (wezterm)

### TMux

Leader (<kbd>F1</kbd>) and:

- <kbd>:</kbd> `new` - create new session
- <kbd>w</kbd> - choose window
- <kbd>\*</kbd> - clears history and terminal
- <kbd>?</kbd> - show key bindings
- <kbd>r</kbd> - reload config
- <kbd>I</kbd> - install plugins
- <kbd>:</kbd> - command mode
- <kbd>$</kbd> - rename session
- <kbd>d</kbd> - detach from session

- <kbd>[</kbd> - enter copy mode
  - <kbd>Space</kbd> - start selection
  - <kbd>Enter</kbd> - copy selection
  - <kbd>]</kbd> - paste selection

#### Sessions

- `tmux ls` - list sessions
- `tmux new -s my-session` - create session
- `tmux a` - attach to new session
- `tmux a -t my-session` - attach to session by name

#### Tmux Windows

- <kbd>F1</kbd> <kbd>+</kbd> - create window
- <kbd>F1</kbd> <kbd>-</kbd> - split window horizontally
- <kbd>F1</kbd> <kbd>|</kbd> - split window vertically
- <kbd>Ctrl</kbd> <kbd>Shift</kbd> right - next window
- <kbd>Ctrl</kbd> <kbd>Shift</kbd> left - previous window
- <kbd>,</kbd> - rename window
- <kbd>.</kbd> - move window

#### Panes

- <kbd>Ctrl</kbd> <kbd>arrows</kbd> - moves between panes (including within nvim)
- <kbd>"</kbd> - split window to panes horizontally
- <kbd>%</kbd> - split window to panes vertically
- <kbd>z</kbd> - zoom pane (toggle)
- <kbd>!</kbd> - move pane to own window
- <kbd>o</kbd> - switch session (interactive with [plugin](https://github.com/omerxx/tmux-sessionx))

### Neovim

- <kbd>F3</kbd> - find string
- <kbd>F4</kbd> - find file
- <kbd>F11</kbd> - toggle DB UI
- <kbd>Space</kbd> is set as leader
  - <kbd>gd</kbd> - go to definition
  - <kbd>e</kbd> - toggle tree view
- <kbd>Tab</kbd> - accept completion
- <kbd>Alt</kbd> <kbd>left/right</kbd> - switch between tabs
- <kbd>Alt</kbd> <kbd></kbd>up</kbd> - close tab
- <kbd>Alt</kbd> <kbd>down</kbd> - pin tab
- <kbd>Ctrl</kbd> <kbd>I</kbd> - go to previous location
  - <kbd>Ctrl</kbd> <kbd>O</kbd> - go to next location

#### Movement

- <kbd>s</kbd> - jump to characters (flash plugin)
- <kbd>gg</kbd> - go to top of the file
  - <kbd>G</kbd> - go to end of the file
- <kbd>20G</kbd> - go to line 20
- <kbd>5j</kbd> - go up 5 lines
  - <kbd>5k</kbd> - go down 5 lines
- <kbd>w</kbd> jump to next word
  - <kbd>b</kbd> jump back to previous word
- <kbd>f</kbd> - find character
  - <kbd>;</kbd> next
- <kbd>m</kbd> - bookmark line (for harpoon)
  - <kbd>TAB</kbd> - toggle bookmark list
- <kbd>/</kbd> - search
  - <kbd>n</kbd> - next hit
- <kbd>f(</kbd> - jump to next bracket

#### Code folding

- <kbd>za</kbd> - Toggle between closing and opening the fold under the cursor.
- <kbd>zR</kbd> - Open all folds in the current buffer.
- <kbd>zM</kbd> - Close all folds in the current buffer.

#### Commenting

- <kbd>gcc</kbd> - comment line

#### Replace

```
:%s/from/to/gc
```

#### Insert mode

- <kbd>F2</kbd> - search/replace (nvim) with LSP
- <kbd>I</kbd> - switch to insert mode + go to beginning of the line
- <kbd>A</kbd> - switch to insert mode + go to end of the line
- <kbd>i</kbd> - switch to insert mode
- <kbd>o</kbd> - switch to insert mode + add new line after current one

#### Visual mode

- <kbd>y</kbd> - copy (yield)
- <kbd>p</kbd> - paste
- <kbd>d</kbd> - cut
- <kbd>dd</kbd> - delete line
- <kbd>u</kbd> - undo
- <kbd>w</kbd> - select word

### Git

- <kbd>Space</kbd> <kbd>gg</kbd> - toggle lazygit
