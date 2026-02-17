#!/bin/sh

if [ "$FOCUSED_WORKSPACE" = "$NAME" ] || [ "space.$FOCUSED_WORKSPACE" = "$NAME" ]; then
  sketchybar --set "$NAME" background.drawing=on \
                           background.color=0xffe1e3e4 \
                           icon.color=0xff1a1b26
else
  sketchybar --set "$NAME" background.drawing=off \
                           icon.color=0xff888888
fi
