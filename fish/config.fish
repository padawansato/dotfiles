export LSCOLORS=gxfxcxdxbxegedabagacad
alias ｌｓ='ls'
alias g='git'

# pyenv
set -x PYENV_ROOT $HOME/.pyenv
set -x PATH  $PYENV_ROOT/bin $PATH
pyenv init - | source
