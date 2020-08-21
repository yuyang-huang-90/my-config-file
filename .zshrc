export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="ys"

CASE_SENSITIVE="true"
DISABLE_AUTO_UPDATE="true"
COMPLETION_WAITING_DOTS="true"

plugins=(git tmux zsh-completions zsh-syntax-highlighting extract)

source $ZSH/oh-my-zsh.sh

## audocomplete
autoload -U compinit promptinit
compinit
promptinit

## using colors
autoload -Uz colors
colors

# fzf
if [ -f ~/.fzf.zsh ]
then
  source ~/.fzf.zsh
  export FZF_DEFAULT_OPTS="--reverse --height 40% \
    --color fg:-1,bg:-1,hl:230,fg+:3,bg+:233,hl+:229\
    --color info:150,prompt:110,spinner:150,pointer:167,marker:174"
fi

# enhanced cd
if [ -f ~/bin/enhancd/init.sh ]
then
  export ENHANCD_COMMAND=ecd
  source ~/bin/enhancd/init.sh
fi

# auto suggestion
if [ -f ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh ]
then
  source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

#source alias
if [ -f "$HOME/.zsh_aliases" ]; then
  source ~/.zsh_aliases
fi
# ===================== Google Speicifc Config ======

