# ghostty-ai-themes — Per-surface theme switching for AI CLI tools in Ghostty
#
# Uses OSC escape sequences to swap terminal colors per-pane,
# so other Ghostty windows/tabs stay untouched.
#
# Source this from your .zshrc:
#   source /path/to/ghostty-ai-themes.zsh

_GAT_VERSION="1.0.0"
_GAT_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/ghostty/theme.yml"

# ── Reset to Ghostty config defaults ─────────────────────────
_gat_reset() {
  printf '\e]110\e\\'   # reset fg
  printf '\e]111\e\\'   # reset bg
  printf '\e]112\e\\'   # reset cursor
  printf '\e]104\e\\'   # reset all 256 palette colors
}

# ── Locate a Ghostty theme file by name ──────────────────────
# Prints path on stdout. Returns 1 if not found.
_gat_find_theme() {
  local name="$1"
  local search_dirs=(
    "${XDG_CONFIG_HOME:-$HOME/.config}/ghostty/themes"
    "/Applications/Ghostty.app/Contents/Resources/ghostty/themes"
  )
  if [[ -n "$XDG_DATA_DIRS" ]]; then
    local dir
    for dir in ${(s/:/)XDG_DATA_DIRS}; do
      search_dirs+=("$dir/ghostty/themes")
    done
  fi
  local d
  for d in "${search_dirs[@]}"; do
    if [[ -f "$d/$name" ]]; then
      printf '%s' "$d/$name"
      return 0
    fi
  done
  return 1
}

# ── Parse a Ghostty theme file into OSC escape sequences ─────
# Reads key=value lines, outputs a single string of escape sequences.
_gat_parse_theme() {
  local theme_file="$1"
  awk '
    BEGIN { FS = " = " }
    /^foreground/   { printf "\\e]10;%s\\e\\\\", $2 }
    /^background/   { printf "\\e]11;%s\\e\\\\", $2 }
    /^cursor-color/ { printf "\\e]12;%s\\e\\\\", $2 }
    /^palette/ {
      split($2, a, "=")
      printf "\\e]4;%s;%s\\e\\\\", a[1], a[2]
    }
  ' "$theme_file"
}

# ── Parse config and create wrapper functions ────────────────
_gat_init() {
  if [[ -n "$SSH_CONNECTION" ]] || [[ ! -f "$_GAT_CONFIG" ]]; then
    return 0
  fi

  local pairs
  pairs=$(awk '
    /^  [a-zA-Z0-9_-]+:/ {
      tool = $1; gsub(/:/, "", tool)
    }
    /^    theme:/ {
      t = $0
      sub(/^    theme: *"?'\''?/, "", t)
      sub(/"?'\''? *$/, "", t)
      print tool "\t" t
    }
  ' "$_GAT_CONFIG")

  local tool theme_name theme_file osc_seq
  while IFS=$'\t' read -r tool theme_name; do
    [[ -z "$tool" ]] && continue

    theme_file=$(_gat_find_theme "$theme_name")
    if [[ $? -ne 0 ]]; then
      printf 'ghostty-ai-themes: theme "%s" not found for "%s", skipping\n' \
        "$theme_name" "$tool" >&2
      continue
    fi

    osc_seq=$(_gat_parse_theme "$theme_file")

    eval "${tool}() {
      printf '${osc_seq}'
      {
        command ${tool} \"\$@\"
      } always {
        _gat_reset
      }
    }"
  done <<< "$pairs"
}

# ── Auto-initialize on source ────────────────────────────────
_gat_init
