alias n="nvim"
alias ls="eza --long --header --icons --octal-permissions --no-user --no-permissions"

# better cd
eval "$(zoxide init zsh)"

# name tmux sessions after the current directory
alias tm='tmux new -s `basename $PWD`'

alias cat="bat"

# init pyenv (already initialized in .zshrc)
# export PYENV_ROOT="$HOME/.pyenv"
# [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init - bash)"
