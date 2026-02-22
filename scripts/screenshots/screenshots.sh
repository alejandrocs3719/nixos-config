#!/usr/bin/env bash

# slurp | grim -g - - | wl-copy

set -euo pipefail

BASE_DIR="${XDG_PICTURES_DIR:-$HOME/pictures}/screenshots"

if [[ "${1:-}" == "--save-image" ]]; then
    TODAY="$(date +%Y-%m-%d)"
    SAVE_DIR="$BASE_DIR/$TODAY"
    mkdir -p "$SAVE_DIR"
    FILE="$SAVE_DIR/$(date +%H-%M-%S).png"

    slurp | grim -g - - | tee "$FILE" | wl-copy
else
    slurp | grim -g - - | wl-copy
fi
