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

#################
#    Aliases    #
#################

# Most important alias: sudo
# This allows all aliases to be used with sudo
alias sudo='sudo '

# General aliases
alias bashrc='vim ~/.bashrc'
alias vimrc='vim ~/.vimrc'
alias cl='clear'
alias shutoff='sudo shutdown now'
alias f='fg'

# ls aliases
alias ll='ls -lhF'
alias lla='ll -a'
alias la='ls -a'
alias l='ls -CF'
alias k='cd .. && l'

# git aliases
alias add='git add'
alias commit='git commit'
alias push='git push'
alias pull='git pull'
alias gpom='git push origin master'

# Program aliases
alias p='python'
alias c='gcc'
alias j='java'
alias v='vim'

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

# goto *any folder* Added support for any computer user
goto () {
     # don't include opt and usr folders in the locate database
     PRNAMES="opt usr"

     # update the database
     updatedb --prunenames="$PRNAMES" -l 0 -U ~/ -o ~/.cache/goto.db 

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

# Sublime shortcut.  Redirects all console output to /dev/null to
# remove the plethora of annoying errors it prodoces
if [ -d /opt/Sublime\ Text\ 2 ]; then
  alias sublime='/opt/Sublime\ Text\ 2/sublime_text &> /dev/null'
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
