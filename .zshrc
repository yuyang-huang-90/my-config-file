export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export PATH=/usr/local/sbin:/usr/local/bin:$PATH:.:~/bin:/usr/local/go/bin
export PATH=/usr/local/opt/ruby/bin:$PATH
export PATH="$HOME/.rvm/bin:$HOME/Dropbox/tools/script:$PATH" # Add RVM to PATH for scripting
export PATH="$HOME/.tmuxifier/bin:$PATH"

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

# Modify the colors and symbols in these variables as desired.
GIT_PROMPT_SYMBOL="%{$fg[cyan]%}git"
GIT_PROMPT_PREFIX="%{$fg[green]%}[%{$reset_color%}"
GIT_PROMPT_SUFFIX="%{$fg[green]%}]%{$reset_color%}"
GIT_PROMPT_MERGING="%{$fg[magenta]%}⚡︎%{$reset_color%}"
GIT_PROMPT_UNTRACKED="%{$fg[red]%}u%{$reset_color%}"
GIT_PROMPT_MODIFIED="%{$fg[yellow]%}m%{$reset_color%}"
GIT_PROMPT_STAGED="%{$fg[green]%}s%{$reset_color%}"

# Show Git branch/tag, or name-rev if on detached head
parse_git_branch() {
  (git symbolic-ref -q HEAD || git name-rev --name-only --no-undefined --always HEAD) 2> /dev/null
}

# Show different symbols as appropriate for various Git repository states
parse_git_state() {

  # Compose this value via multiple conditional appends.
  local GIT_STATE=""

  local GIT_DIR="$(git rev-parse --git-dir 2> /dev/null)"
  if [ -n $GIT_DIR ] && test -r $GIT_DIR/MERGE_HEAD; then
    GIT_STATE=$GIT_STATE$GIT_PROMPT_MERGING
  fi

  if [[ -n $(git ls-files --other --exclude-standard 2> /dev/null) ]]; then
    GIT_STATE=$GIT_STATE$GIT_PROMPT_UNTRACKED
  fi

  if ! git diff --quiet 2> /dev/null; then
    GIT_STATE=$GIT_STATE$GIT_PROMPT_MODIFIED
  fi

  if ! git diff --cached --quiet 2> /dev/null; then
    GIT_STATE=$GIT_STATE$GIT_PROMPT_STAGED
  fi

  if [[ -n $GIT_STATE ]]; then
    echo "$GIT_PROMPT_PREFIX$GIT_STATE$GIT_PROMPT_SUFFIX"
  fi

}

# If inside a Git repository, print its branch and state
git_prompt_string() {
  local git_where="$(parse_git_branch)"
  [ -n "$git_where" ] && echo "$GIT_PROMPT_SYMBOL$(parse_git_state)$GIT_PROMPT_PREFIX%{$fg[yellow]%}${git_where#(refs/heads/|tags/)}$GIT_PROMPT_SUFFIX"
}

# Set the right-hand prompt
RPROMPT='$(git_prompt_string)'
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

# some difference between OS X and Linux
# for mac only
if ls / | grep "Applications" > /dev/null # if sys is os x then change sth.
then
    LS_COLOR='-G'
    alias mvim='/Applications/MacVim.app/Contents/MacOS/Vim'
    alias svim='sudo /Applications/MacVim.app/Contents/MacOS/Vim'
    alias eclimd='/Applications/eclipse/eclimd'
    alias sage='/Applications/sage/local/bin/sage'
    export SAGE_ROOT='/Applications/sage'
    export JAVA_HOME=$(/usr/libexec/java_home)
    export JDK_HOME=$(/usr/libexec/java_home)
else
    # for linux only
    LS_COLOR='--color'
    alias mvim='vim'
    alias eclimd='~/eclipse/eclimd'
    alias svim='sudo vim'
    export PATH=$PATH:~/adt-bundle-linux-x86_64-20140702/sdk/platform-tools:~/adt-bundle-linux-x86_64-20140702/sdk/tools
    export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64
    export PATH=$PATH:${JAVA_HOME}

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


# set TERM xterm256
export TERM="xterm-256color"

# for tmuxifier
#eval "$(tmuxifier init -)"
export TMUXIFIER_LAYOUT_PATH="$HOME/.tmux-layouts"


