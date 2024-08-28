# alias code='open -a "Visual Studio Code" .'

# better cd
eval "$(zoxide init zsh)"
alias cd="z"

alias n="nvim"

alias ls="eza --long --header --icons --git --octal-permissions --no-user --no-permissions"

alias sl="screen -ls"

alias cat="bat"

alias python="$(brew --prefix python@3.11)/libexec/bin/python"

source alias ai=~/ai-cli/ai