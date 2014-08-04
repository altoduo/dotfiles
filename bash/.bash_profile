# this is where common includes go

# add scripts directory to path
if [ -d ~/scripts ]; then
    PATH="$HOME/scripts:$PATH"
fi

# if there is a symlink to awesomerc scripts inside
# scripts folder, then include it
if [ -d ~/scripts/dotfiles ]; then
    PATH="$HOME/scripts/dotfiles:$PATH"
fi

# include usr directory on login
if [ -d ~/usr/bin ]; then
    PATH="$HOME/usr/bin:$PATH"
fi

if [ -e /Applications/Spotify.app ]; then
    source $AWESOME_PATH/scripts/spotify/bashSpotify
fi

export OS=$(uname)
