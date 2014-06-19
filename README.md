dotfiles
=========

This repository contains many valueable shortcuts and autonomous scripts for various applications listed below.

RC
---
The RC files for commonly used linux applications include:

1. Bash
2. Vim

Other applications include:

1. [Git](http://git-scm.com/)
2. [Splunk](http://splunk.com)
3. [Terminator](http://gnometerminator.blogspot.com/p/introduction.html)

These files include hot key shortcuts, color schemes, functions for various purposes.

Scripts
-------

In addition to the configuration files we have accumulated some scripts to make life simpler.

Installation
------------

1. Clone into any prefered directory
2. Update all submodules: `git submodule update --init --recursive`
3. Pull all submodules: `git submodule foreach git pull`
4. Recommended: Make a symlink `ln -s` to RC directories into your home folder `~/`
