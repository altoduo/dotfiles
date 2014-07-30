dotfiles
=========

Dotfiles contains configuration for several commonly used \*nix utlities.

Setup
----
Typical configuration involves importing the dotfiles into your own custom
dotfiles directories.  Bash and Git both support this behavior.  If you are
importing, make sure to export the environment variable `AWESOME_PATH` as the
root directory of the dotfiles path.


Config Files
---
The RC files for commonly used linux applications include:

1. [Bash](http://www.gnu.org/software/bash/)
2. [Git](http://git-scm.com/)
3. [Vim](http://www.vim.org/)
4. [Terminator](http://gnometerminator.blogspot.com/p/introduction.html)

These files include hot key shortcuts, color schemes, functions for various purposes.

Scripts
-------

In addition to the configuration files we have accumulated some scripts to make life simpler.
One nice utility we have is the `goto` command.  This lets you instantly cd into your desired
folder by means of the `locate` command.

Installation
------------

1. Clone into any prefered directory
2. Update all submodules: `git submodule update --init --recursive`
3. Pull all submodules: `git submodule foreach git pull`
4. Recommended: Make a symlink `ln -s` to RC directories into your home folder `~/`
