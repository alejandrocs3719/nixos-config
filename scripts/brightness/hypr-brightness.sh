#!/usr/bin/env bash

# Script: hypr-brightness.sh
# Opens Rofi to change focused monitor brightness

# Check dependencies
for cmd in hyprctl rofi; do
  if ! command -v "$cmd" >/dev/null 2>&1; then
    echo "Error: $cmd no encontrado en PATH."
    exit 1
  fi
done

# 1. Obtain focused monitor
FOCUSED_MON=$(hyprctl monitors | awk '
  /^Monitor / {
    mon=$2
    gsub(":", "", mon)   # quitar ":" al final por si acaso
  }
  /^\tfocused:/ {
    if ($2 == "yes") {
      print mon
      exit
    }
  }
')

if [[ -z "$FOCUSED_MON" ]]; then
  notify-send "Brightness" "Could not detect focused monitor"
  exit 1
fi

MON_NAME="$FOCUSED_MON"

# 2. Pedir brillo con rofi (0–100)
# Ponemos "50" como valor por defecto editable

#BRIGHTNESS=$(printf "20\n40\n60\n80\n100" | rofi -dmenu -p "Brightness 0-100 (${MON_NAME})" -lines 1)

BRIGHTNESS=$(rofi -dmenu -p "Brightness 0-100 (${MON_NAME})" -lines 1)

# If rofi is cancelled:
if [[ -z "$BRIGHTNESS" ]]; then
  exit 0
fi

# Validate number input
if ! [[ "$BRIGHTNESS" =~ ^[0-9]+$ ]]; then
  notify-send "Brillo" "Valor inválido: $BRIGHTNESS"
  exit 1
fi

# Range 0-100
if (( BRIGHTNESS < 0 || BRIGHTNESS > 100 )); then
  notify-send "Brillo" "El valor debe estar entre 0 y 100"
  exit 1
fi

# 3. Check if the focused monitor is internal
IS_INTERNAL=false
case "$MON_NAME" in
  eDP-*|LVDS-* )
    IS_INTERNAL=true
    ;;
esac

# 4. Internal monitors use brightenssctl
if [[ "$IS_INTERNAL" == true ]]; then
  if ! command -v brightnessctl >/dev/null 2>&1; then
    notify-send "Brightness" "brightnessctl not found"
    exit 1
  fi

  brightnessctl set "${BRIGHTNESS}%" -d intel_backlight
  notify-send "Brightness" "Monitor ${MON_NAME}: ${BRIGHTNESS}%"
  exit 0
fi

# 5. external monitors use ddcutil
if ! command -v ddcutil >/dev/null 2>&1; then
  notify-send "Brightness" "ddcutil not found"
  exit 1
fi

# Map Hyprland monitors too Display N from ddcutil 
case "$MON_NAME" in
  DP-1)
    DISPLAY_NUM=1
    ;;
  HDMI-A-1)
    DISPLAY_NUM=2
    ;;
  *)
    notify-send "Brightness" "External monitor not mapped: ${MON_NAME}"
    exit 1
    ;;
esac

ddcutil --display "$DISPLAY_NUM" setvcp 10 "$BRIGHTNESS" && \
  notify-send "Brillo" "Monitor ${MON_NAME} (Display ${DISPLAY_NUM}): ${BRIGHTNESS}"
