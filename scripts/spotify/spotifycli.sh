#!/bin/bash

####################################################
#           Linux Shell Spotify Control            #
#           github.com:altoduo/dotfiles            #
# Adapted from github.com/mgarratt/spotify-control #
####################################################

if [ $# -lt 1 ]
then
        echo "Please provide an argument:"
        echo ""
        echo ""
        echo "toggle:       Toggles play/pause"
        echo "next:         Skip to the next track"
        echo "prev:         Skip to the previous track"
        echo "getTitle:     Prints the current song's name"
        echo "getArtist:    Prints the current song's artist"
        echo "getAlbum:     Prints the current song's album"
        echo "getStatus:    Prints Playing/Paused"
        echo ""
        echo ""
        echo "If using spotibash:"
        echo ""
        echo ""
        echo "sp:          Toggles play/pause"
        echo "sps:         Prints the status"
        echo "spn:         Skip to the next track"
        echo "spp:         Skip to the previous track"
        echo ""
        echo ""
        exit
fi

if [ "$(pidof spotify)" = "" ]
then
  echo "Spotify is not running"
  exit
fi

case $1 in
    "toggle")
        dbus-send --print-reply=literal --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause
        ;;
    "next")
        dbus-send --print-reply=literal --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Next
        ;;
    "prev")
        dbus-send --print-reply=literal --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Previous
        ;;
    "getTitle")
        dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'Metadata'|egrep -A 1 "title"|egrep -v "title"|cut -b 44-|cut -d '"' -f 1|egrep -v ^$
        ;;
    "getArtist")
        dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'Metadata'|egrep -A 2 "artist"|egrep -v "artist"|egrep -v "array"|cut -b 27-|cut -d '"' -f 1|egrep -v ^$
        ;;
    "getAlbum")
        dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'Metadata'|egrep -A 2 "album"|egrep -v "album"|egrep -v "array"|cut -b 44-|cut -d '"' -f 1|egrep -v ^$
        ;;
    "getSpotifyStatus")
        dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'PlaybackStatus'|grep 'string "[^"]*"'|sed 's/.*"\(.*\)"[^"]*$/\1/'
        ;;
    "getStatus")
        dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'Metadata'|egrep -A 1 "title"|egrep -v "title"|cut -b 44-|cut -d '"' -f 1|egrep -v ^$
        dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'Metadata'|egrep -A 2 "album"|egrep -v "album"|egrep -v "array"|cut -b 44-|cut -d '"' -f 1|egrep -v ^$
        dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'Metadata'|egrep -A 2 "artist"|egrep -v "artist"|egrep -v "array"|cut -b 27-|cut -d '"' -f 1|egrep -v ^$
        ;;
    *)
        echo "Unknown command: " $1
        ;;
esac
