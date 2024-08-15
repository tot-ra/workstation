## Mac workstation setup
Yay. You got new laptop. Now you need to set it up

### Typical apps
- iTerm
- Goland
- VSCode
- Notion
- Slack
- Sequel Pro
- Docker4Mac

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
