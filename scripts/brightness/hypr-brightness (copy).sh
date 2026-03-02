#!/usr/bin/env bash

# Script: hypr-brightness.sh
# Usage: hypr-brightness.sh up | down

ACTION="$1"  # "up" o "down"

if [[ -z "$ACTION" ]]; then
  echo "Usage: $0 up|down"
  exit 1
fi

# 1. Get focused monitor
FOCUSED_MONITOR=$(hyprctl monitors | awk '
  $1 == "Monitor" { name=$2 }
  $1 == "focused:" && $2 == "yes" { print name }
')

if [[ -z "$FOCUSED_MONITOR" ]]; then
  echo "Could not detect focused monitor"
  exit 1
fi

# Remove possible ":" at the end (eDP-1:)
FOCUSED_MONITOR=${FOCUSED_MONITOR%:}

# 2. Choose a brightness change command depending on the focused output
case "$FOCUSED_MONITOR" in
  eDP-1)
    # Portátil integrado
    if [[ "$ACTION" == "up" ]]; then
      brightnessctl -d intel_backlight set +5%
    else
      brightnessctl -d intel_backlight set 5%-
    fi
    ;;

  HDMI-A-1)
    # Monitor externo 1
    echo "HDMI-A-1"
    if [[ "$ACTION" == "up" ]]; then
      ddcutil --display 2 setvcp 10 + 10
    else
      ddcutil --display 2 setvcp 10 - 10
    fi
    ;;

  DP-1)
    echo "DP-1"
    # Otro monitor externo
    if [[ "$ACTION" == "up" ]]; then
      ddcutil --display 1 setvcp 10 + 10
    else
      ddcutil --display 1 setvcp 10 - 10
    fi
    ;;

  *)
    echo "Non-recognized focused monitor: $FOCUSED_MONITOR"
    exit 1
    ;;
esac
