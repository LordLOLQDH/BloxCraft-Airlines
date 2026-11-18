#!/usr/bin/env bash
set -euo pipefail
SOURCE_DIR="$(cd "$(dirname "$0")" && pwd)"
if [ "$#" -ge 1 ]; then
  TARGET_ROOT="$1"
else
  TARGET_ROOT="$HOME/.fgfs/Aircraft"
fi
TARGET_DIR="$TARGET_ROOT/BloxCraft-Airlines"
mkdir -p "$TARGET_DIR"
cp -R "$SOURCE_DIR/." "$TARGET_DIR/"
if [ "$#" -ge 2 ]; then
  FG_ROOT="$2"
  ENGINE_DIR="$FG_ROOT/Aircraft/Generic/JSBSim/Engines"
  if [ ! -d "$ENGINE_DIR" ]; then
    echo "Could not find JSBSim engine folder: $ENGINE_DIR" >&2
    echo "Pass the actual FlightGear data directory as the second argument." >&2
    exit 1
  fi
  cp "$SOURCE_DIR/Engines/BC001-Turbojet.xml" "$ENGINE_DIR/BC001-Turbojet.xml"
  echo "Custom BC-001 engine installed to: $ENGINE_DIR"
else
  echo "NOTE: Copy Engines/BC001-Turbojet.xml into FG_ROOT/Aircraft/Generic/JSBSim/Engines/"
fi
echo "BC-001 aircraft installed to: $TARGET_DIR"
echo "Select BloxCraft-Airlines in FlightGear."
