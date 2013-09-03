#!/bin/bash

# this is where common includes go

[[ -f ~/.bashrc ]] && . ~/.bashrc

# add scripts directory to path
if [ -L "~/scripts" ]; then
	PATH="$HOME/scripts:$PATH"
fi

# include usr directory on login
if [ -d "~/usr/bin" ]; then
	PATH="$HOME/usr/bin:$PATH"
fi
