################################
#    AwesomeRC's BashRC File   #
################################

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
HISTCONTROL=$HISTCONTROL${HISTCONTROL+:}ignoredups
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

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

#if [ "$color_prompt" = yes ]; then
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
#    PS1='\[\e[0;32m\]\u\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[1;32m\]\$\[\e[m\] \[\e[1;37m\]'

#else
    #PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
#    PS1='\[\e[0;32m\]\u\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[1;32m\]\$\[\e[m\] \[\e[1;37m\]'
#fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

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

# most important alias: sudo
# this allows all aliases to be used with sudo
alias sudo='sudo '

# ls aliases
alias ll='ls -lhF'
alias lla='ll -a'
alias la='ls -a'
alias l='ls -CF'
alias k='cd .. && ls'

# git aliases
alias add='git add'
alias com='git commit'
#alias push="git pull origin master && git push origin master"
alias push="sync origin master"		# now compatible with new function

# etc aids
alias cl='clear'
alias shutoff='sudo shutdown now'

#
# Functions
#

# changes directory and lists the content inside
function cdl () {
     cd $1
     ls
 }

#goto *any folder* Added support for any computer user
goto () {
     USER=$(whoami)
     PLACE="/home/"
     REST="/(Dropbox|Documents|Downloads|Desktop)"
     cd "$(locate -i "$@" | grep -P $PLACE$USER$REST | awk '{print length(), $0 | "sort -n" }' | head -n 1 | cut -d " " -f2-)"; 
}

#SSH into Rasberry Pi with unknown IP address
rpi () {
      T="$(date +%s)"
      echo "Testing IP Adresses..."
      ACTIVEIPS=$(nmap -sP 192.168.1.1-255 | grep 'Nmap scan report for' | awk '{ print $5 }')
      echo "Testing valid SSH servers..."
      for ip in $ACTIVEIPS; do
          echo "Time in seconds: $(($(date +%s)-T))"
          echo "Time in seconds: ${T}"
          echo "pi@$ip"
          eval "ssh pi@$ip"
      done
}

# synchronizes git folder with specified upstream and branch
sync () {
	git pull $1 $2
	git push $1 $2
}

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi
