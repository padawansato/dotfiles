# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
eval /Users/e155755/.pyenv/versions/anaconda3-5.3.0/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<



# 相対行番号
set relativenumber
# peco
set fish_plugins theme peco

function fish_user_key_bindings
  bind \ct peco_select_history # Bind for prco history to Ctrl+r
end

# fzf
# set -U FZF_LEGACY_KEYBINDINGS 0
# set -U FZF_REVERSE_ISEARCH_OPTS "--reverse --height=100%"
# export FZF_DEFAULT_OPTS='--height 100% --reverse --border'

# ディレクトリカラー
export LSCOLORS=gxfxcxdxbxegedabagacad

# manual 更新
# 遅いのでコメントアウト
# fish_update_completions

# プロンプトの日付非表示
set -U theme_display_date no 
# conda activate
source (conda info --root)/etc/fish/conf.d/conda.fish

# =======================================================================
# alias
# alias ls='exa -al -s date'
alias ｃｄ='cd'
# =======================================================================
# alias end

