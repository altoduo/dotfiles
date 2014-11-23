# this is where common includes go

# add scripts directory to path
if [ -d ~/scripts ]; then
    PATH="$HOME/scripts:$PATH"
fi

# put the latest version of ruby gems
if [ -d ~/.gem ]; then
  # find the latest version
  LATEST_VERSION=($(ls -1 ~/.gem/ruby | sort -r))
  GEM_BIN_FOLDER="$HOME/.gem/ruby/${LATEST_VERSION[0]}/bin"

  # only add the folder if it exists (to be doubly sure)
  if [ -d "$GEM_BIN_FOLDER" ]; then
    PATH="$PATH:$GEM_BIN_FOLDER"
  fi
fi

# include usr directory on login
if [ -d ~/usr/bin ]; then
    PATH="$HOME/usr/bin:$PATH"
fi

if [ -e /Applications/Spotify.app ]; then
    source $DOTFILES_PATH/scripts/spotify/bashSpotify
fi

export OS=$(uname)
