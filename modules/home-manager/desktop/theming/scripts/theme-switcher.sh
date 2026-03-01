#!/usr/bin/env bash

THEMES_DIR="$HOME/.config/theming/themes"
THEME_STATE_DIR="$XDG_STATE_HOME/current-theme"

themes=(
    "Tokyo Night"
    "Everforest"
    "Gruvbox"
    "Matugen"
)

THEME=$(printf "%s\n" "${themes[@]}" | rofi -dmenu -p "themes")


# exit if no theme is chosen
[ -z "$THEME" ] && exit 0

# remove old symlinks

case "$THEME" in
    "Tokyo Night")
        "$THEMES_DIR/tokyo-night.sh"
        ;;
    Everforest)
        "$THEMES_DIR/everforest.sh"
        ;;
    Gruvbox)
        "$THEMES_DIR/gruvbox.sh"
        ;;
    Matugen)
esac