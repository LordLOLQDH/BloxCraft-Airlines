#!/usr/bin/env bash
set -euo pipefail
SOURCE_DIR="$(cd "$(dirname "$0")" && pwd)"
TARGET_ROOT="$HOME/.fgfs/Aircraft"
if [ "$#" -ge 1 ]; then TARGET_ROOT="$1"; fi
TARGET_DIR="$TARGET_ROOT/BloxCraft-Airlines"
mkdir -p "$TARGET_DIR"
cp -R "$SOURCE_DIR/." "$TARGET_DIR/"
echo "BC-001 installed to: $TARGET_DIR"
echo "The aircraft-local Engines/ folder is included."
echo "Select BloxCraft-Airlines in FlightGear."