#!/bin/bash

RUNNING=$(osascript -e 'tell application "System Events" to (name of processes) contains "Music"' 2>/dev/null)

if [ "$RUNNING" = "true" ]; then
  STATE=$(osascript -e 'tell application "Music" to player state as string' 2>/dev/null)
  if [ "$STATE" = "playing" ] || [ "$STATE" = "paused" ]; then
    TRACK=$(osascript -e 'tell application "Music" to name of current track as string' 2>/dev/null)
    ARTIST=$(osascript -e 'tell application "Music" to artist of current track as string' 2>/dev/null)

    if [ "$STATE" = "paused" ]; then
      sketchybar --set music icon.color=0x80888888 label="$ARTIST — $TRACK" drawing=on
    else
      sketchybar --set music icon.color=0xffFC3C44 label="$ARTIST — $TRACK" drawing=on
    fi

    sketchybar --set music.next drawing=on
  else
    sketchybar --set music drawing=off \
               --set music.next drawing=off
  fi
else
  sketchybar --set music drawing=off \
             --set music.next drawing=off
fi
