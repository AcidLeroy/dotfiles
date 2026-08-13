
# ~/.zshenv puts Homebrew first, but /etc/zprofile runs path_helper *after*
# .zshenv in login shells and hoists /usr/bin above /opt/homebrew/bin -- which
# silently swaps Homebrew python3 for Apple's. Re-assert here; `typeset -U path`
# drops the now-duplicate entries further down the list.
path=(/opt/homebrew/bin /opt/homebrew/sbin $path)

# Source an expensive `<tool> init zsh` from cache, regenerating only when the
# binary is newer than the cache. Saves ~100ms/shell (atuin ~85ms, starship ~12ms).
_cached_init() {
  local name=$1; shift
  local cache=$HOME/.cache/zsh-init/$name.zsh
  local bin=${commands[$name]}
  if [[ ! -s $cache || -z $bin || $bin -nt $cache ]]; then
    mkdir -p $cache:h
    "$@" >| $cache 2>/dev/null || return
  fi
  source $cache
}

# Skip oh-my-zsh's compaudit permission scan of every fpath dir (~80ms).
ZSH_DISABLE_COMPFIX=true

# Custom commands that only function at work
[[ -f ~/.zshrc_work ]] && source ~/.zshrc_work
#[[ -f ~/.kubebuilder_completion ]] && source ~/.kubebuilder_completion

# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"


# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
#ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# User configuration
alias vim=nvim
alias k=kubectl

# These enables  vim in the command line. Unlike vim mode in the Alacritty terminal, 
# this will allow you to edit the cursor position. The Alacritty terminal will 
# only allow you to copy and navigate text that has already been output, but not
# the current terminal. As a result, I included this so that I can mess the current
# command which I find the most useful feature of being able to navigate vim in 
# the terminal. 
bindkey -v
# These rebinds enable forward and backward search. These get messed up when 
# using the "bindkey -v" command above.
#bindkey ^R history-incremental-search-backward 
#bindkey ^S history-incremental-search-forward



# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#export PATH="/usr/local/opt/openjdk/bin:$PATH"
_cached_init starship starship init zsh
export PATH="${HOME}/go/bin:${PATH}"
export KUBE_EDITOR=nvim

#source ~/.zsh/zsh-kubectl-prompt/kubectl.zsh
#RPROMPT='%{$fg[blue]%}($ZSH_KUBECTL_PROMPT)%{$reset_color%}'


# Autocompletion stuff for kubebuilder
[[ -f ~/.kubebuilder_completion ]] && source ~/.kubebuilder_completion
alias okta-sync='granted sso populate --sso-region us-east-1 https://d-9067bf0e58.awsapps.com/start#'
alias gitpush='git add -u && git commit --amend --no-edit && git push -f'

kgetall() {
  if [[ -z "$1" ]]; then
    echo "Usage: kgetall <namespace>"
    return 1
  fi
  kubectl api-resources --verbs=list --namespaced -o name | \
    xargs -n 1 kubectl get --show-kind --ignore-not-found -n "$1"
}

# Pin Teleport to the persistent kubeconfig. `kubie ctx` spawns a subshell with
# KUBECONFIG set to an ephemeral temp file holding only the selected context, so
# `tsh kube login` run inside a kubie shell writes the new contexts into that temp
# file -- deleted on exit, never seen by kubie. Workflow is `tsh kube login --all`
# once, then pick with `kubie ctx`; new contexts show up in a *new* shell.
tsh() {
  KUBECONFIG="$HOME/.kube/config" command tsh "$@"
}

# Atuin (shell history) 
source $HOME/.atuin/bin/env
_cached_init atuin atuin init zsh
export PATH="$HOME/.local/bin:$PATH"

# Launch Brave with CDP remote-debugging port for chrome-devtools-mcp (Claude Code).
# Brave ignores --remote-debugging-port if already running, so quit first.
# The browser-settings toggle is broken on this version; the CLI flag is the reliable path.
brave() {
  if pgrep -x "Brave Browser" >/dev/null 2>&1; then
    echo "Brave running — quitting to apply --remote-debugging-port=9222"
    osascript -e 'quit app "Brave Browser"'
    sleep 2
  fi
  open -na "Brave Browser" --args --remote-debugging-port=9222
}
#export VAULT_ADDR="https://vault.tuk.us.omniva.cloud:8200"

# bun completions
[ -s "/Users/codyeilar/.bun/_bun" ] && source "/Users/codyeilar/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Re-apply uniqueness. `typeset -U path` in ~/.zshenv only dedupes on *array*
# assignment; the `export PATH="x:$PATH"` lines above assign the scalar, which
# slips duplicates past it when a nested shell inherits an already-built PATH.
# path only -- fpath is already deduped in ~/.zshenv and compinit has run by now.
typeset -U path
