#!/bin/bash

osascript -e '
tell application "System Events"
  tell process "Spotify"
    click menu item "Like" of menu "Song" of menu bar 1
  end tell
end tell
' 2>/dev/null
