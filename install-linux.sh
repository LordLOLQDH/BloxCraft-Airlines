#!/usr/bin/env bash
set -euo pipefail
SOURCE_DIR="$(cd "$(dirname "\${BASH_SOURCE[0]}")" && pwd)"
TARGET_ROOT="\${1:-$HOME/.fgfs/Aircraft}"
TARGET_DIR="$TARGET_ROOT/BloxCraft-Airlines"
mkdir -p "$TARGET_DIR"
cp -R "$SOURCE_DIR/." "$TARGET_DIR/"
echo "BC-001 installed to: $TARGET_DIR"
echo "In FlightGear, select BloxCraft-Airlines or start with:"
echo "  fgfs --aircraft=BloxCraft-Airlines --aircraft-dir=\"$TARGET_ROOT\""
