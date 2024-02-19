# PATH
set PATH /usr/local/bin /usr/sbin $PATH

# alias
alias ｌｓ='ls'
alias g='git'
alias gs='git status'
alias ｇｓ='git status'
alias p='prevd'
alias n='nextd'

## docker
alias d='docker'
alias dps='docker ps -a'
alias dls='docker container ls'
alias dc='docker compose'
alias dcu='docker compose up'
alias dcud='docker compose up -d'
alias dcd='docker compose down'

# pyenv
set -x PYENV_ROOT $HOME/.pyenv
set -x PATH $PYENV_ROOT/shims $PATH
pyenv init - | source

# git
export TAG="date +DEPLOYED-%F/%H:%M"

# go
set -x GOENV_ROOT $HOME/.goenv
set -x PATH $GOENV_ROOT/bin $PATH
eval (goenv init - | source)
set -x PATH $GOPATH/bin $PATH
