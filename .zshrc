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

#PROMPT
PROMPT="
%{$terminfo[bold]$fg[blue]%}#%{$reset_color%} \
%(#,%{$bg[yellow]%}%{$fg[black]%}%n%{$reset_color%},%{$fg[cyan]%}%n) \
%{$fg[white]%}@ \
%{$fg[green]%}%m \
%{$fg[white]%}in \
%{$terminfo[bold]$fg[yellow]%}%~%{$reset_color%}\
 \
%{$fg[white]%}[%*] $exit_code
%{$terminfo[bold]$fg[red]%}$ %{$reset_color%}"
#RPROMPT
autoload -Uz vcs_info

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:git*' formats "%{$fg[cyan]%}[%b]%{$reset_color%}(%{$fg[green]%}%c%{$reset_color%}%{$fg[red]%}%u%{$reset_color%})"
precmd() {
    vcs_info
}
RPROMPT=\$vcs_info_msg_0_
