#!/bin/bash

RUNNING=$(osascript -e 'tell application "System Events" to (name of processes) contains "Spotify"' 2>/dev/null)

if [ "$RUNNING" = "true" ]; then
  STATE=$(osascript -e 'tell application "Spotify" to player state as string' 2>/dev/null)
  if [ "$STATE" = "playing" ] || [ "$STATE" = "paused" ]; then
    TRACK=$(osascript -e 'tell application "Spotify" to name of current track as string' 2>/dev/null)
    ARTIST=$(osascript -e 'tell application "Spotify" to artist of current track as string' 2>/dev/null)

    if [ "$STATE" = "paused" ]; then
      sketchybar --set spotify icon.color=0x80888888 label="$ARTIST — $TRACK" drawing=on
    else
      sketchybar --set spotify icon.color=0xff1DB954 label="$ARTIST — $TRACK" drawing=on
    fi

    sketchybar --set spotify.next drawing=on
  else
    sketchybar --set spotify drawing=off \
               --set spotify.next drawing=off
  fi
else
  sketchybar --set spotify drawing=off \
             --set spotify.next drawing=off
fi
