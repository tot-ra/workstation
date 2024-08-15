## Mac workstation setup
Yay. You got new laptop. Now you need to set it up

### Typical apps
- Goland
- VSCode
- Notion
- Slack

### Github 
```bash
ssh-keygen -t rsa -b 4096 -C "artkurapov@gmail.com"
cat ~/.ssh/id_rsa.pub
# add key to github --> https://github.com/settings/ssh/new
```


```bash
git clone git@github.com:tot-ra/mac-work.git ~/git/mac-work
echo "source ~/git/mac-work/mount.sh" >> ~/.zshrc
```
