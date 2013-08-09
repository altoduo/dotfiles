#!/bin/bash

# this is where common includes go

[[ -f ~/.bashrc ]] && . ~/.bashrc

# add scripts directory to path
if [ -d "$HOME/scripts" ]; then
	PATH="$HOME/scripts:$PATH"
fi

# include usr directory on login
if [ -d "$HOME/usr/bin" ]; then
	PATH="$HOME/usr/bin:$PATH"
fi

# include the lib package config for opt directories
if [ -d "/opt/pkgconfig.d" ]; then
	PKG_CONFIG_PATH="$PKG_CONFIG_PATH:/opt/pkgconfig.d"
fi

