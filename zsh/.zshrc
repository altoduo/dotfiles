#!/bin/zsh

############################################
#               dotfiles                   #
#   git@github.com:altoduo/dotfiles.git    #
############################################

# Let's ease into the transition
{source ~/.bashrc 2>&1} > /dev/null
PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
alias k="cd .."

# Autotab
autoload -U compinit
compinit

# Autocompletion
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
#zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'
setopt correctall
unsetopt correct_all

# Prompt
autoload -U promptinit
promptinit
prompt suse
autoload -U colors && colors
#export PS1="%{$fg[red]%}%n.%{$reset_color%}%m %C > "
PROMPT="%{$fg[blue]%}%n%{$resetcolor%}.%{$fg[green]%}%m%{$resetcolor%} %{$fg[cyan]%}%c%{$resetcolor%} >%{$reset_color%} "

# VCS Info module
autoload -Uz vcs_info

# Colors
export CLICOLOR=YES  # Works on OSX
source $DOTFILES_PATH/zsh/colored-man.zsh

# History
export HISTSIZE=2000
export HISTFILE="$HOME/.zsh_history"
export SAVEHIST=$HISTSIZE
setopt hist_ignore_all_dups
bindkey '^R' history-incremental-search-backward
setopt hist_ignore_space  # Don't record entries preceeded with a space

# Auto cd: name the dir
setopt autocd
function chpwd() {
    emulate -L zsh
    ls #-a
}

function count() {
  ls -1 $1 | wc -l
}

# Extended glob includes regex
setopt extendedglob

#############
# Functions #
#############

bindkey    "^[[3~"          delete-char
bindkey    "^[3;5~"         delete-char
