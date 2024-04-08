#PS4="+%D{%s.%.}> "
#set -o xtrace
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="amuse"
plugins=(git z vi-mode asdf)

# remove ruby version from the prompt
RPROMPT=''

function load_source(){
  [[ -s "$1" ]] && source "$1"
}

if type "brew" > /dev/null; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
  load_source /opt/homebrew/opt/asdf/libexec/asdf.sh
fi

load_source $ZSH/oh-my-zsh.sh

if type "tmux" > /dev/null; then
  load_source "$HOME/.bin/tmuxinator.zsh"
fi

load_source "$HOME/.homesick/repos/homeshick/homeshick.sh"

# OSX check
if [[ "$OSTYPE" == "darwin"* ]]; then
  load_source "/Users/jperi/.vim/plugged/gruvbox/gruvbox_256palette_osx.sh"
else
  load_source "/Users/jperi/.vim/plugged/gruvbox/gruvbox_256palette.sh"
fi

# sudo previous command
alias fuck='sudo $(fc -ln -1)'
# setting tmux in 265 colors
alias tmux='tmux -2'
# kill all the tmux sessions
alias kill-tmux="tmux ls | cut -d ':' -f 1 | xargs -I% tmux kill-session -t % "

alias pushn="git symbolic-ref --short -q HEAD | xargs git push -u origin"

if type nvim > /dev/null; then
  alias vim='nvim'
fi

alias notifyDone='tput bel; terminal-notifier -title "Terminal" -message "Done with task! Exit status: $?" --sound default' -activate com.apple.Terminal

export TERM=screen-256color
export EDITOR='nvim'
# To be able to open vim for current command. Check https://github.com/ohmyzsh/ohmyzsh/issues/9588
export KEYTIMEOUT=15

# Golang configurations
export GOPATH="$HOME/workspace/go"
export PATH="$PATH:$GOPATH/bin"

# Vi mode.
bindkey "^R" history-incremental-search-backward

# Add node_modules to path
export PATH=$PATH:node_modules/.bin
# add sbin to path, as brew installs stuff there
export PATH="/usr/local/sbin:$PATH"

# Allow to extend in a local basis
load_source "$HOME/.zshrc.local"

export ERL_AFLAGS="-kernel shell_history enabled"

# load fzf config if it exists
if type "fzf" > /dev/null; then
  load_source ~/.fzf.zsh
fi

if type "rbenv" > /dev/null; then
  eval "$(rbenv init -)"
fi

if type "direnv" > /dev/null; then
  eval "$(direnv hook zsh)"
fi

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# The next line updates PATH for the Google Cloud SDK.
load_source "/Users/jperi/google-cloud-sdk/path.zsh.inc"

# The next line enables shell command completion for gcloud.
load_source "/Users/jperi/google-cloud-sdk/completion.zsh.inc"

