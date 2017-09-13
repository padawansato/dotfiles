
##zsh再起動
alias zshcommit='exec $SHELL -l'
alias relogin='exec $SHELL -l'

# users generic .zshrc file for zsh(1)

## Environment variable configuration
#
# LANG
#
export LANG=ja_JP.UTF-8 ## pandas
case ${UID} in
0)
    LANG=C
    ;;
esac

## eigo python pandas
## https://stackoverflow.com/questions/30761152/how-to-solve-import-error-for-pandas
export LC_ALL=ja_JP.UTF-8 # en_US.UTF-8 #
export LANG= #ja_JP.UTF-8


## Default shell configuration
#
# set prompt
#
autoload -Uz colors
colors
case ${UID} in
0)
    PROMPT="%{${fg[cyan]}%}$(echo ${HOST%%.*} | tr '[a-z]' '[A-Z]') %B%{${fg[red]}%}%/#%{${reset_color}%}%b "
    PROMPT2="%B%{${fg[red]}%}%_#%{${reset_color}%}%b "
    SPROMPT="%B%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%}%b "
    ;;
*)
    PROMPT="%{${fg[red]}%}%/%%%{${reset_color}%} "
    PROMPT2="%{${fg[red]}%}%_%%%{${reset_color}%} "
    SPROMPT="%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%} "
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
        PROMPT="%{${fg[cyan]}%}$(echo ${HOST%%.*} | tr '[a-z]' '[A-Z]') ${PROMPT}"
    ;;
esac

# auto change directory
#
setopt auto_cd

# auto directory pushd that you can get dirs list by cd -[tab]
#
setopt auto_pushd

# command correct edition before each completion attempt
#
setopt correct

# compacked complete list display
#
setopt list_packed

# no remove postfix slash of command line
#
setopt noautoremoveslash

# no beep sound when complete list displayed
#
setopt nolistbeep


## Keybind configuration
#
# emacs like keybind (e.x. Ctrl-a gets to line head and Ctrl-e gets
#   to end) and something additions
#
bindkey -e
bindkey "^[[1~" beginning-of-line # Home gets to line head
bindkey "^[[4~" end-of-line # End gets to line end
bindkey "^[[3~" delete-char # Del

# historical backward/forward search with linehead string binded to ^P/^N
#
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end
bindkey "\\ep" history-beginning-search-backward-end
bindkey "\\en" history-beginning-search-forward-end

# reverse menu completion binded to Shift-Tab
#
bindkey "\e[Z" reverse-menu-complete


## Command history configuration
#
HISTFILE=${HOME}/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt hist_ignore_dups     # ignore duplication command history list
setopt share_history        # share command history data


## Completion configuration
#
fpath=(${HOME}/.zsh/functions/Completion ${fpath})
autoload -U compinit
compinit


## zsh editor
#
autoload zed

#ssh tab auto comp
autoload -U compinit && compinit

function print_known_hosts (){ 
    if [ -f $HOME/.ssh/known_hosts ]; then
        cat $HOME/.ssh/known_hosts | tr ',' ' ' | cut -d' ' -f1 
    fi
}
_cache_hosts=($( print_known_hosts ))


## Prediction configuration
#
#autoload predict-on
#predict-off


## Alias configuration
#
# expand aliases before completing
#
setopt complete_aliases     # aliased ls needs if file/dir completions work

alias where="command -v"
alias j="jobs -l"

case "${OSTYPE}" in
freebsd*|darwin*)
    alias ls="ls -G -w"
    ;;
linux*)
    alias ls="ls --color"
    ;;
esac

alias la="ls -a"
alias lf="ls -F"
alias ll="ls -l"
alias ｌｓ="ls"

alias du="du -h"
alias df="df -h"

alias su="su -l"

alias cd..="cd .."
alias ....="cd ../.."
alias cd....="cd ../.."
alias cd ....="cd ../.."
alias ......="cd ../../.."
alias cd......="cd ../../.."
alias cd ......="cd ../../.."
alias ｃｄ="cd"

alias pu="pushd"
alias dirs="dirs -v"

alias emac="emacs"
alias e="emacs"
alias えまｃｓ="emacs"
alias え="emacs"

alias E="/usr/local/Cellar/emacs/25.2/Emacs.app/ ; open Emacs.app"
#alias Emacs="/usr/local/Cellar/emacs/25.2/Emacs.app/ ; open -a Emacs.app"
#alias emacs='/usr/local/Cellar/emacs/25.2/Emacs.app/Contents/MacOS/Emacs -nw'
alias ea="open -a emacs "#Emacs.app　windowが複数できる．
#http://keisanbutsuriya.hateblo.jp/entry/2015/02/13/133858
alias ekill="emacsclient -e '(kill-emacs)'"
alias ee='emacsclient -n' #Emacs.appで素早く開くためM-x server start->ekill
#alias Emacs='/usr/local/Cellar/emacs/25.2/Emacs.app/ ; open Emacs.app;popd;emacsclient -n' #Emacs.appで素早く開くためM-x server start->ekill
#alias ec='emacsclient -n ""'#error , eeなら
alias Emacs='/Applications/Emacs.app/Contents/MacOS ; open Emacs    .app;popd;emacsclient -n'
alias emacs='/Applications/Emacs.app/Contents/MacOS/Emacs -nw'
#$emacs hogeで普通に開ける
#2017/03/23時点
#しかし，上記aliasがなくてもターミナルで開かれる，これはなぜか分からない


alias yo="youtube-dl"
#
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

#autojump
#alias j="autojump"
#if [ -f `brew --prefix`/etc/autojump ]; then
#  . `brew --prefix`/etc/autojump
#fi

# cd した先のディレクトリをディレクトリスタックに追加する
# ディレクトリスタックとは今までに行ったディレクトリの履歴のこと
# `cd +<Tab>` でディレクトリの履歴が表示され、そこに移動できる
#setopt auto_pushd
# pushd したとき、ディレクトリがすでにスタックに含まれていればスタックに追加しない
#setopt pushd_ignore_dups



## terminal configuration
#
case "${TERM}" in
screen)
    TERM=xterm
    ;;
esac

case "${TERM}" in
xterm|xterm-color)
    export LSCOLORS=exfxcxdxbxegedabagacad
    export LS_COLORS='di=36;40:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43'
    zstyle ':completion:*' list-colors 'di=36' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
    ;;
kterm-color)
    stty erase '^H'
    export LSCOLORS=exfxcxdxbxegedabagacad
    export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
    zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
    ;;
kterm)
    stty erase '^H'
    ;;
cons25)
    unset LANG
    export LSCOLORS=ExFxCxdxBxegedabagacad
    export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
    zstyle ':completion:*' list-colors 'di=;34;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
    ;;
jfbterm-color)
    export LSCOLORS=gxFxCxdxBxegedabagacad
    export LS_COLORS='di=01;36:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
    zstyle ':completion:*' list-colors 'di=;36;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
    ;;
esac

# set terminal title including current directory
#
case "${TERM}" in
xterm|xterm-color|kterm|kterm-color)
#kterm*|xterm)
    precmd() {
        echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
    }
    ;;
esac
#peco hokan kinou
function peco-history-selection() {
    BUFFER=`history -n 1 | tail -r  | awk '!a[$0]++' | peco`
    CURSOR=$#BUFFER
    zle reset-prompt
}

zle -N peco-history-selection
bindkey '^R' peco-history-selection


## load user .zshrc configuration file
#
[ -f ${HOME}/.zshrc.mine ] && source ${HOME}/.zshrc.mine

#anadonda
PATH=$PATH:$HOME/anaconda/bin

### Virtualenvwrapper
# if [ -f /usr/local/bin/virtualenvwrapper.sh ]; then
#     export WORKON_HOME=$HOME/.virtualenvs
#     source /usr/local/bin/virtualenvwrapper.sh
# fi

#pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

alias sl='ls'
alias -g zshrc="/Users/e155755/.dotfiles/dotfiles/.zshrc"

#zshprofile if you want to know time
#if (which zprof > /dev/null) ;then
#  zprof | less
#fi

#export PATH="/Users/e155755/.cask/bin:$PATH"

#cdr
# cdr, add-zsh-hook を有効にする
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs
# cdr の設定
# http://wada811.blogspot.com/2014/09/zsh-cdr.html
# cdr -l
# cdr [number]
zstyle ':completion:*' recent-dirs-insert both
zstyle ':chpwd:*' recent-dirs-max 500
zstyle ':chpwd:*' recent-dirs-default true
zstyle ':chpwd:*' recent-dirs-file "$HOME/.cache/shell/chpwd-recent-dirs"
zstyle ':chpwd:*' recent-dirs-pushd true

# akahori 
# autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
# add-zsh-hook chpwd chpwd_recent_dirs
 
# echo -n "move past directory? (y/N/num) "
# read
# if [[ "$REPLY" =~ ^[Yy]$ ]] || [[ "$REPLY" == '' ]]; then
 cdr
# else
# ;
# fi


#path
#haskell
#ghc
# Add GHC 7.10.3 to the PATH, via https://ghcformacosx.github.io/
export GHC_DOT_APP="/private/var/folders/r0/lyh8j8g91w5d_rgcjgpm1p3r0000gn/T/AppTranslocation/3C9683CF-CEFD-40F8-BBB8-6FD5D46BB413/d/ghc-7.10.3.app"
if [ -d "$GHC_DOT_APP" ]; then
  export PATH="${HOME}/.local/bin:${HOME}/.cabal/bin:${GHC_DOT_APP}/Contents/bin:${PATH}"
fi


# from tawada report
export PYENV_ROOT=${HOME}/.pyenv
if [ -d "${PYENV_ROOT}" ]; then
    export PATH=${PYENV_ROOT}/bin:$PATH
#   export PATH=${PYENV_ROOT}/bin:$PATH
fi

# jupyter notebook
export BROWSER=open

## Go 環境設定
# if [ -x "`which go`" ]; then
#     export GOPATH=$HOME/.go
#     export PATH=$PATH:$GOPATH/bin
# fi

#
export PATH="/usr/local/bin:$PATH"
