# .zlogout
if [[ $TERM == "xterm-ghostty" ]]; then
    true
elif [[ $TERM == "xterm-256color" ]]; then
  echo -e "\033]50;SetProfile=local\a"
fi
