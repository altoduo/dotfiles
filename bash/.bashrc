################################
#    AwesomeRC's BashRC File   #
################################

#################
#    Colors     #
#################

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Colored prompt
force_color_prompt=yes

# Set Some Colors
export TERM=xterm-256color
BGREEN='\[\033[1;32m\]'
GREEN='\e[0;32m'
BRED='\[\033[1;31m\]'
RED='\[\033[0;31m\]'
BBLUE='\[\033[1;34m\]'
BLUE='\[\033[0;34m\]'
NORMAL='\[\033[00m\]'
WHITE='\e[1;37m'
YELLOW='\[\033[0;33m\]'

# Prompt
if [ -e "/usr/share/git/git-prompt.sh" ]; then
    . /usr/share/git/git-prompt.sh      # import the interactive git prompt script
fi
export PS1="${BGREEN}\u ${BLUE}\w${YELLOW}\$(__git_ps1) ${RED}\$ ${NORMAL}"

#################
#    Aliases    #
#################

# Most important alias: sudo
# This allows all aliases to be used with sudo
alias sudo='sudo '

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# General aliases
alias bashrc='vim ~/.bashrc'
alias vimrc='vim ~/.vimrc'
alias cl='clear'
alias shutoff='sudo shutdown now'
alias f='fg'
alias xpbcopy='xclip -selection clipboard'
alias xpbpaste='xclip -selection clipboard -o'

# ls aliases
alias ll='ls -lhFG'
alias lla='ll -a'
alias la='ls -a'
alias l='ls -CF'
alias k='cd .. && l'

# git aliases
alias add='git add'
alias commit='git commit'
alias push='git push'
alias pull='git pull'
alias pullr='git pull -r'
alias gpom='git push origin master'
alias status='git status'

# Program aliases
alias p='python'
alias c='gcc'
alias j='java'
alias v='vim'

# MAC OS aliases
if [ "$OS"="Darwin" ]; then
    FINDUTIL_DIR="/usr/local/Cellar/findutils/4.4.2/bin"
    alias locate="$FINDUTIL_DIR/glocate"
    alias updatedb="$FINDUTIL_DIR/gupdatedb"
fi

#################
#   Functions   #
#################

# Changes directory and lists the content inside
function cdl () {
     cd $1
     l
}

# Make directory and cd into it
mcd () { mkdir "$1" && cd "$1"; }

# Look in directory without cd into it
pk () {
    cd $1
    la
    cd ..
}

# pbcopy made simple
pbc () {
    cat $1 | pbcopy
}

xpbc () {
    cat $1 | xpbcopy
}

# keep track of OS for the goto function
export OS=$(uname)

# goto *any folder* Added support for any computer user
goto () {
    GOTO_ROOT=$(echo ~)

    PRNAMES="opt usr"
    PRPATHS="$GOTO_ROOT/opt $GOTO_ROOT/usr $GOTO_ROOT/Library $GOTO_ROOT/.Trash $GOTO_ROOT/Music $GOTO_ROOT/Pictures $GOTO_ROOT/Applications $GOTO_ROOT/Downloads $GOTO_ROOT/tmp $GOTO_ROOT/.*"

    if [ "$OS"="Darwin" ]; then
        updatedb --localpaths="$GOTO_ROOT" --prunepaths="$PRPATHS" --output="$GOTO_ROOT/.cache/goto.db"
    else
        # update the database
        updatedb --prunenames="$PRNAMES" -l 0 -U ~/ -o ~/.cache/goto.db
    fi

     # and then search it
     cd "$(locate -d ~/.cache/goto.db -i "$@" | awk '{print length(), $0 | "sort -n" }' | head -n 1 | cut -d " " -f2)";
}

#################
#    History    #
#################

# Remove duplicates in history
HISTCONTROL=$HISTCONTROL${HISTCONTROL+:}ignoredups
HISTCONTROL=ignoreboth

# Append to the history file, don't overwrite it
shopt -s histappend

#################
#    Titles     #
#################

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

#################
#     Misc      #
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

# Sublime shortcut.  Redirects all console output to /dev/null to
# remove the plethora of annoying errors it prodoces
if [ -d /opt/Sublime\ Text\ 2 ]; then
  alias sublime='/opt/Sublime\ Text\ 2/sublime_text &> /dev/null'
fi

# HomeBrew Completion Files
brew_bash_completion_dir='/usr/local/etc/bash_completion.d'
if [ -d $brew_bash_completion_dir ]; then
    for file in $brew_bash_completion_dir/*; do
        if [[ -f "$file" ]]; then
            source "$file"
        fi
    done
fi

#################
#   Stuff Idk   #
#################

# Make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# Set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
# We have color support; assume it's compliant with Ecma-48
# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
# a case would tend to support setf rather than setaf.)
color_prompt=yes
    else
color_prompt=
    fi
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi
