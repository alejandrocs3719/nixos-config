#!/usr/bin/env bash

# Directory containing wallpapers
WALLPAPER_DIR="$HOME/wallpapers"
# Symlink to changed wallpaper
SYMLINK_PATH="/home/alejandro/.local/state/wallpapers/current-wallpaper"

# Rofi theme file
ROFI_THEME="$HOME/.config/rofi/themes/big-icons.rasi"

# Get ALL monitor names from Hyprland
mapfile -t MONITORS < <(hyprctl monitors | awk '/Monitor/ {print $2}')

if [ ${#MONITORS[@]} -eq 0 ]; then
    echo "No monitors found."
    exit 1
fi

# Check if wallpaper directory exists
if [ ! -d "$WALLPAPER_DIR" ]; then
    echo "Wallpaper directory does not exist: $WALLPAPER_DIR"
    exit 1
fi

# Change to wallpaper directory so relative paths work
cd "$WALLPAPER_DIR" || exit 1

# Show rofi menu with image previews as icons
SELECTED_NAME="$(
  for WP in *.{jpg,jpeg,png,webp}; do
      # Skip if no files matched this glob
      [ -e "$WP" ] || continue
      # TEXT\0icon\x1fFULL_PATH\n
      echo -en "$WP\0icon\x1f$WALLPAPER_DIR/$WP\n"
  done | rofi -dmenu -show-icons -theme "$ROFI_THEME" -p "Wallpaper"
)"

# Exit if rofi was cancelled
[ -z "$SELECTED_NAME" ] && exit 0

# Full path of selected wallpaper
SELECTED_PATH="$WALLPAPER_DIR/$SELECTED_NAME"

if [ ! -f "$SELECTED_PATH" ]; then
    echo "Selected wallpaper not found: $SELECTED_PATH"
    exit 1
fi

# Apply wallpaper to ALL monitors using hyprpaper
for MON in "${MONITORS[@]}"; do
    hyprctl hyprpaper wallpaper "$MON, $SELECTED_PATH"
done

# Ensure that the symlink path exists
mkdir -p "$(dirname "$SYMLINK_PATH")"

# Remove old symlink/file if it exists
rm -f "$SYMLINK_PATH"

# Create new symlink pointing to selected wallpaper
ln -s "$SELECTED_PATH" "$SYMLINK_PATH"
