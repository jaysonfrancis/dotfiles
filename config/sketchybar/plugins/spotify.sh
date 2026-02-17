#!/bin/bash

PLAYING=$(osascript -e 'tell application "System Events" to (name of processes) contains "Spotify"' 2>/dev/null)

if [ "$PLAYING" = "true" ]; then
  STATE=$(osascript -e 'tell application "Spotify" to player state as string' 2>/dev/null)
  if [ "$STATE" = "playing" ]; then
    TRACK=$(osascript -e 'tell application "Spotify" to name of current track as string' 2>/dev/null)
    ARTIST=$(osascript -e 'tell application "Spotify" to artist of current track as string' 2>/dev/null)
    sketchybar --set "$NAME" label="$ARTIST — $TRACK" drawing=on
  elif [ "$STATE" = "paused" ]; then
    TRACK=$(osascript -e 'tell application "Spotify" to name of current track as string' 2>/dev/null)
    ARTIST=$(osascript -e 'tell application "Spotify" to artist of current track as string' 2>/dev/null)
    sketchybar --set "$NAME" label="$ARTIST — $TRACK" drawing=on
  else
    sketchybar --set "$NAME" drawing=off
  fi
else
  sketchybar --set "$NAME" drawing=off
fi
