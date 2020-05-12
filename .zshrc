export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export PATH=/usr/local/sbin:/usr/local/bin:$PATH:.:~/bin:/usr/local/go/bin
export PATH=~/homebrew/bin:/usr/local/sbin:/usr/local/bin:$PATH:.:~/bin:/usr/local/go/bin
#export PATH=/usr/local/opt/ruby/bin:$PATH
#export PATH="$HOME/.rvm/bin:$HOME/Dropbox/tools/script:$PATH" # Add RVM to PATH for scripting

HISTFILE=$HOME/.zsh-history
HISTSIZE=1000
SAVEHIST=1000


# rebind backward search to fix ctrl-r broken in tmux
bindkey -e

## audocomplete
autoload -U compinit promptinit
compinit
promptinit

## using colors
autoload -Uz colors
colors

## customize prompt
PROMPT="[%{$fg[green]%}%n%{$reset_color%}@%{$fg[cyan]%}%m %{$fg_no_bold[magenta]%}%1~ %{$reset_color%}]%# "

# modified right side prompt to shwo git information
#RPROMPT="[%{$fg_no_bold[red]%}%?%{$reset_color%}]"

## prevent overwriting when there is no newline
unsetopt promptcr

# make aliases distinct command
setopt complete_aliases
## first subject to parameter expansion
setopt prompt_subst

## nobeep
setopt nobeep
# list jop in long format by default
setopt long_list_jobs
# list the type
setopt list_types

# not autoremove slash
setopt noautoremoveslash

## auto resume the jop
setopt auto_resume

# automatically list choice on ambiguous choice
setopt auto_list
# list in packed format
setopt list_packed

## ignore duplicate history
setopt hist_ignore_dups

## cd auto  push
setopt autopushd

## do not push same dir
setopt pushd_ignore_dups

## extend the ~ etc.
setopt extended_glob

## using tab change manu
setopt auto_menu

## writng start&end time to histtory
setopt extended_history

## perform =filename expandshing
setopt equals

## magic subst
setopt magic_equal_subst

## when call the history; only reload the line
setopt hist_verify

# sort in numeric order
setopt numeric_glob_sort

## auto complete brack
setopt auto_param_keys
## share history
setopt share_history


#print char in eight_bit
setopt print_eightbit
## auto add slash to dir
setopt auto_param_slash
## enable completion colors
zstyle ':completion:*:default' menu select=1

## colorizing the completion list
#eval `dircolors`
export LSCOLORS=ExFxCxdxBxegedabagacad
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
export ZLS_COLORS=$LS_COLORS
export EDITOR=vim
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# setup rprompt with git
#
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes false
turn_on_git_stage_check() {
  zstyle ':vcs_info:*' check-for-changes true
}
#zstyle ':vcs_info:*' stagedstr '!'
#zstyle ':vcs_info:*' unstagedstr '?'
zstyle ':vcs_info:git*' formats "%{$fg[cyan]%}[%b]%{$reset_color%}(%{$fg[green]%}%c%{$reset_color%}%{$fg[red]%}%u%{$reset_color%})"
#zstyle ':vcs_info:git*' formats "%{$fg[green]%}%s %{$reset_color%}%r/%S%{$fg[grey]%} %{$fg[blue]%}%b%{$reset_color%}%m%u%c%{$reset_color%} "
#zstyle ':vcs_info:git*' formats "%s  %r/%S %b %m%u%c "

RPROMPT=\$vcs_info_msg_0_


# some difference between OS X and Linux
# for mac only
if ls / | grep "Applications" > /dev/null # if sys is os x then change sth.
then
    LS_COLOR='-G'
    alias eclimd='/Applications/eclipse/eclimd'
    alias sage='/Applications/sage/local/bin/sage'
    export SAGE_ROOT='/Applications/sage'
	  alias mvim='/usr/local/bin/vim'
    #export JAVA_HOME=$(/usr/libexec/java_home)
    #export JDK_HOME=$(/usr/libexec/java_home)
else
	# for linux only
	LS_COLOR='--color'
	alias mvim='vim'
  alias nvim='vim'
	alias eclimd='~/eclipse/eclimd'
	alias svim='sudo vim'
	export PATH=$PATH:~/adt-bundle-linux-x86_64-20140702/sdk/platform-tools:~/adt-bundle-linux-x86_64-20140702/sdk/tools
  eval $(thefuck --alias)
fi

#for peco snip
# Search shell history with peco: https://github.com/peco/peco
# Adapted from: https://github.com/mooz/percol#zsh-history-search
#if which peco &> /dev/null; then
#  function peco_select_history() {
#    local tac
#    { which gtac &> /dev/null && tac="gtac" } || \
#      { which tac &> /dev/null && tac="tac" } || \
#      tac="tail -r"
#    BUFFER=$(fc -l -n 1 | eval $tac | \
#                peco --query "$LBUFFER")
#    CURSOR=$#BUFFER # move cursor
#    zle -R -c       # refresh
#  }
#
#  zle -N peco_select_history
#  bindkey '^R' peco_select_history
#fi

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


#git related config
if [ -f ~/zsh-plugin/git.plugin.zsh ]
then
  turn_on_git_stage_check
  source ~/zsh-plugin/git.plugin.zsh
fi

# auto suggestion
if [ -f ~/zsh-plugin/zsh-autosuggestions/zsh-autosuggestions.zsh ]
then
  source ~/zsh-plugin/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# common alias
alias ls='ls $LS_COLOR'
alias ll='ls $LS_COLOR -alF'
alias la='ls $LS_COLOR -CA'
alias l='ls $LS_COLOR -CF'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias vp3='source ~/workspace/python3-venv/bin/activate'


# some more alias to avoid making mistake
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias c='clear'

# nvim alias
alias nvimf='nvim $(fzf)'

# set TERM xterm256
#export TERM="xterm-256color"


#export PATH=$PATH:~/go/bin:~/gocode/bin:~/Dropbox/cloud-computing-capstone/openrepo/misc
#export GOPATH=$HOME/gocode
#export GOROOT=~/go
#export PATH=$HOME/anaconda3/bin:/home/m/spark/bin:~/.bin:~/sbt/bin:/home/m/pintos/src/utils:$PATH:/home/m/sbt/bin:/home/m/kafka/bin


# rust
#source $HOME/.cargo/env



# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/m/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/m/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/m/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/m/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

