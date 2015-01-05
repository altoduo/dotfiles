#!/bin/zsh

############################################
#               dotfiles                   #
#   git@github.com:altoduo/dotfiles.git    #
############################################

# Autotab
autoload -U compinit
compinit

# Autocompletion
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
#zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'
setopt correctall

# Prompt
autoload -U promptinit
promptinit
prompt suse
export PS1="%n.%m %~ > "


# History
export HISTSIZE=2000
export HISTFILE="$HOME/.zsh_history"
export SAVEHIST=$HISTSIZE
setopt hist_ignore_all_dups
bindkey '^R' history-incremental-search-backward
setopt hist_ignore_space  # Don't record entries preceeded with a space

# Auto cd: name the dir
setopt autocd

# Extended glob includes regex
setopt extendedglob

#############
# Functions #
#############

# Autovim: name the file
function command_not_found_handler()
{
    emulate -L zsh
    for file in $@ ; do test -e $file && vim $file:A ; done
}
