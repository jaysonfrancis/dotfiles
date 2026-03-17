#!/bin/sh

# Colors
FOCUSED_BG=0xff7aa2f7       # blue accent
FOCUSED_ICON=0xff1a1b26      # dark text on blue
OCCUPIED_ICON=0xff9ece6a      # green - has windows
EMPTY_ICON=0xff565f89         # gray/subtle - no windows
DEFAULT_BG=0xe01a1b26         # item pill background

# Extract workspace number from item name (e.g. "space.3" -> "3")
SID="${NAME#space.}"

if [ "$FOCUSED_WORKSPACE" = "$SID" ]; then
  sketchybar --set "$NAME" background.drawing=on \
                           background.color=$FOCUSED_BG \
                           icon.color=$FOCUSED_ICON
else
  WINDOW_COUNT=$(aerospace list-windows --workspace "$SID" --count)
  if [ "$WINDOW_COUNT" -gt 0 ] 2>/dev/null; then
    sketchybar --set "$NAME" background.drawing=on \
                             background.color=$DEFAULT_BG \
                             icon.color=$OCCUPIED_ICON
  else
    sketchybar --set "$NAME" background.drawing=on \
                             background.color=$DEFAULT_BG \
                             icon.color=$EMPTY_ICON
  fi
fi
