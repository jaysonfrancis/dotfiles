#!/bin/sh

if [ "$FOCUSED_WORKSPACE" = "$NAME" ] || [ "space.$FOCUSED_WORKSPACE" = "$NAME" ]; then
  sketchybar --set "$NAME" background.drawing=on \
                           background.color=0xff7aa2f7 \
                           icon.color=0xff1a1b26
else
  sketchybar --set "$NAME" background.drawing=on \
                           background.color=0xe01a1b26 \
                           icon.color=0xff565f89
fi
