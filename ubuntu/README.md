## ubuntu-speicific setup

Assuming ubuntu v22, x86 64bit. 

```
curl -s https://raw.githubusercontent.com/tot-ra/workstation/main/ubuntu/install.sh | bash && \
curl -s https://raw.githubusercontent.com/tot-ra/workstation/main/ubuntu/aliases.sh > aliases.sh && \
echo "source ~/aliases.sh" >> ~/.zshrc
```

## Manual steps
- set `zsh` as default command in Gnome Terminal preferences
- consider installing vino-server for remote VNC access
- consider installing sshd

