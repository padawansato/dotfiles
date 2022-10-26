# PATH
set PATH /usr/local/bin /usr/sbin $PATH

export LSCOLORS=gxfxcxdxbxegedabagacad
alias ｌｓ='ls'
alias g='git'
alias gs='git status'
alias ｇｓ='git status'

# pyenv
set -x PYENV_ROOT $HOME/.pyenv
set -x PATH $PYENV_ROOT/shims $PATH
pyenv init - | source

# git
export TAG="date +DEPLOYED-%F/%H:%M"

test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

# docker
alias dls='docker container ls'
