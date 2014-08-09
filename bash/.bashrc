############################################
#               dotfiles                   #
# git@github.com:DepthDeluxe/dotfiles.git  #
############################################

#################
#    Colors     #
#################

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# import bash_colors script
source "$AWESOME_PATH/bash/bash_colors"

# Prompt - check if git-prompt.sh exists first
fancy_ps1="\[${BGreen}\]\u \[${Blue}\]\w\[${Yellow}\]\$(__git_ps1) \[${Red}\]\$ \[${Color_Off}\]"
export PS1=${fancy_ps1}

simple_ps1="\[${BGreen}\]\u \[${Blue}\]\w \[${Red}\]\$ \[${Black}\]"

# import git-prompt
if [ -e "/usr/share/git/git-prompt.sh" ]; then
    source "/usr/share/git/git-prompt.sh"
elif [ -e "/usr/local/etc/bash_completion.d/git-prompt.sh" ]; then
    source "/usr/local/etc/bash_completion.d/git-prompt.sh"
elif [ -e "/etc/bash_completion.d/git-prompt" ]; then
    source "/etc/bash_completion.d/git-prompt"
else
    export PS1=${simple_ps1}
fi

#################
#   Functions   #
#################

source "$AWESOME_PATH/bash/functions.sh"

#################
#    Aliases    #
#################

# Most important alias: sudo
# This allows all aliases to be used with sudo
alias sudo='sudo '

# enable color support of ls and also add handy aliases
if [ -x "/usr/bin/dircolors" ] || [ "$OS" = "Darwin" ]; then
    if [ "$OS" != "Darwin" ]; then
        test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
        alias ls='ls --color=auto'
    else
        alias ls='ls -G'
    fi

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# General aliases
alias cddot='cd $AWESOME_PATH'
alias bashrc="$EDITOR ~/scripts/dotfiles/bash/.bashrc"
alias vimrc="$EDITOR ~/scripts/dotfiles/vim/.vimrc"
alias vi='vim'
alias cl='clear'
alias shutoff='sudo shutdown now'
alias f='fg'
alias xpbcopy='xclip -selection clipboard'
alias xpbpaste='xclip -selection clipboard -o'
alias pbc='cat $1 | pbcopy'
alias xpbc='cat $1 | xpbcopy'
alias tailf='tail -f'

# ls/cd aliases
alias cd='cdmagic'
alias ll='ls -lhF'
alias lla='ll -a'
alias la='ls -a'
alias l='ls -CFh'
alias k='\cd .. && l'

# default untar command
alias untar='tar -zcvf'

# Program aliases
alias p='python'
alias m='make'
alias c='gcc'
alias j='java'
alias v='vim'

# MAC OS aliases
if [ "$OS" = "Darwin" ]; then
    FINDUTIL_DIR="/usr/local/Cellar/findutils/4.4.2/bin"
    alias locate="$FINDUTIL_DIR/glocate"
    alias updatedb="$FINDUTIL_DIR/gupdatedb"
fi

#################
#    History    #
#################

# Remove duplicates in history
HISTCONTROL=$HISTCONTROL${HISTCONTROL+:}ignoredups
HISTCONTROL=ignoreboth

# Append to the history file, don't overwrite it
shopt -s histappend

#################
# Shell Options #
#################

# Dynamic line length based on window size
shopt -s checkwinsize

# Correct mistyped dir names
shopt -s cdspell

# Case-insensitive matching for filename results
shopt -s nocaseglob

#Set editor and visual variable
set -o vi
export EDITOR=vim

#################
#  XTerm / SSH  #
#################

# Set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

if [ -n "$force_color_prompt" ]; then
    if [ -x "/usr/bin/tput" ] && tput setaf 1 >&/dev/null; then
# We have color support; assume it's compliant with Ecma-48
# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
# a case would tend to support setf rather than setaf.)
color_prompt=yes
    else
color_prompt=
    fi
fi

#
# Completion imports
#

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f "/etc/bash_completion" ] && ! shopt -oq posix; then
    source "/etc/bash_completion"
fi

# HomeBrew Completion Files
brew_bash_completion_dir='/usr/local/etc/bash_completion.d'
if [ -d "$brew_bash_completion_dir" ]; then
    for file in "$brew_bash_completion_dir/*"; do
        if [[ -f "$file" ]]; then
            source "$file"
        fi
    done
fi

# import git-completion if it exists
if [ -e "/usr/share/git/git-completion.bash" ]; then
    source "/usr/share/git/git-completion.bash"
fi
