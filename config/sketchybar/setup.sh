#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(builtin cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$HOME/.config/sketchybar"

mkdir -p "$CONFIG_DIR/plugins"
cp "$SCRIPT_DIR/sketchybarrc" "$CONFIG_DIR/sketchybarrc"
cp "$SCRIPT_DIR/plugins/"*.sh "$CONFIG_DIR/plugins/"
chmod +x "$CONFIG_DIR/plugins/"*.sh

echo "SketchyBar config installed to $CONFIG_DIR"
echo ""
echo "Next steps:"
echo "  1. Hide macOS menu bar: System Settings > Control Center > 'Automatically hide and show the menu bar' > Always"
echo "  2. Start SketchyBar: brew services start sketchybar"
