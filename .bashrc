# customized .bashrc

# path
export PATH=$PATH:.

# ps1
export PS1='[\u@\h:\w]\$ '
# some difference between OS X and Linux
LS_COLOR='--color'
alias mvim='vim'
alias svim='sudo vim'
if ls / | grep "Applications" > /dev/null # if sys is os x then change sth.
then
    LS_COLOR='-G'
    alias mvim='/Applications/MacVim.app/Contents/MacOS/Vim'
    alias svim='sudo /Applications/MacVim.app/Contents/MacOS/Vim'
fi

alias ls='ls $LS_COLOR'
alias ll='ls $LS_COLOR -alF'
alias la='ls $LS_COLOR -CA'
alias l='ls $LS_COLOR -CF'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# some more alias to avoid making mistake
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'


export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
