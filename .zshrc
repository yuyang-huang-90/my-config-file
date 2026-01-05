# -------------------------------
# Prompt setup (conditional)
# -------------------------------
if [[ "$(whoami)" == "yuyanghuang" ]]; then
  # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
  # Initialization code that may require console input (password prompts, [y/n]
  # confirmations, etc.) must go above this block; everything else may go below.
  if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
  fi
fi

# -------------------------------
# Zinit setup
# -------------------------------
export ZINIT_HOME="$HOME/.zinit"
source "$ZINIT_HOME/bin/zinit.zsh"

if [[ "$(whoami)" == "yuyanghuang" ]]; then
  # Use Powerlevel10k
  zinit light romkatv/powerlevel10k
  [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
else
  # Use Starship
  eval "$(starship init zsh)"
fi

# -------------------------------
# Completion system
# -------------------------------
# Only initialize if not already done by system config
if [[ -z "${_comps}" ]]; then
  autoload -Uz compinit
  # Use cache and only rebuild once per day for performance
  if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
    compinit -d "${ZDOTDIR:-$HOME}/.zcompdump"
  else
    compinit -C -d "${ZDOTDIR:-$HOME}/.zcompdump"
  fi
fi

# -------------------------------
# Plugin management
# -------------------------------

# Load completions immediately (needed for other plugins)
zinit light zsh-users/zsh-completions

# Load plugins with turbo mode (defer loading for faster startup)
zinit ice wait lucid
zinit light zsh-users/zsh-autosuggestions

zinit ice wait lucid
zinit light Aloxaf/fzf-tab

# Load syntax-highlighting last with turbo mode
zinit ice wait lucid atinit"zpcompinit; zpcdreplay"
zinit light zsh-users/zsh-syntax-highlighting

# Git plugin (deferred)
zinit ice wait lucid
zinit snippet https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/plugins/git/git.plugin.zsh

# Extract plugin (deferred)
zinit ice wait lucid
zinit snippet https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/plugins/extract/extract.plugin.zsh

# Tmux plugin (deferred)
zinit ice wait lucid
zinit snippet https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/plugins/tmux/tmux.plugin.zsh

# FZF integration (manual, outside oh-my-zsh plugin system)
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS="--reverse --height 40% \
  --color fg:-1,bg:-1,hl:230,fg+:3,bg+:233,hl+:229\
  --color info:150,prompt:110,spinner:150,pointer:167,marker:174"

# Zoxide - use zinit's from"gh-r" for binary and eval for init
zinit ice wait lucid from"gh-r" as"program"
zinit light ajeetdsouza/zoxide
zinit ice wait lucid atload'eval "$(zoxide init zsh)"'
zinit light zdharma-continuum/null

# -------------------------------
# Options
# -------------------------------
setopt no_beep
setopt autocd
setopt correct

# history settings
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt share_history

# key binding
setopt ignore_eof
bindkey -e

# -------------------------------
# Aliases and custom functions
# -------------------------------

[ -f "$HOME/.zsh_aliases" ] && source "$HOME/.zsh_aliases"

function gdsi() {
  local commit=${1:-HEAD}
  git icdiff "$commit~1" "$commit"
}

function validate_tf() {
  for dir in $(find . -type d); do
    if ls $dir/*.tf >/dev/null 2>&1; then
      echo "Validating $dir"
      (
        cd $dir
        terraform init -backend=false >/dev/null 2>&1
        terraform validate
      )
    fi
  done
}

function ai_commit() {
  if [ -z "$1" ]; then
    echo "Usage: $0 <commit_message_text>"
    return
  fi
  clippy ask "Your task is to proofread and update the commit message delimited by triple backticks.
You must first summarize the message in a single sentence which is less than 60 characters, then followed by the elaborated description. The commit message is publicly visible to make it accurate and concise.
I need the response in a format I can directly paste to the git commit message.
\`\`\`
$1
\`\`\`"
}

function ai_japanese() {
  if [ -z "$1" ]; then
    echo "Usage: $0 <text_to_translate>"
    return 1
  fi
  clippy ask "Your task is to translate the following message delimited by triple backticks into Japanese. Make it professional but not too formal.
\`\`\`
$1
\`\`\`"
}

function git_current_branch() {
  git rev-parse --abbrev-ref HEAD 2>/dev/null
}

# fnm - defer initialization for faster startup
if command -v fnm &> /dev/null; then
  eval "$(fnm env --use-on-cd --shell zsh)"
fi
