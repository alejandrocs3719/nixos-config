#!/usr/bin/env bash

# We detect if we are plugged to AC; if we are, then change the refresh rate to the maximum.
AC_ONLINE=$(cat /sys/class/power_supply/ACAD/online 2>/dev/null || echo 0)

if [ "$AC_ONLINE" = "1" ]; then
    # Plugged
    hyprctl keyword monitor eDP-1,2560x1600@240,auto,auto
    # notify-send "󱐋 Power" "Refresh rate changed to 240Hz"
else
    # Battery
    hyprctl keyword monitor eDP-1,2560x1600@60,auto,auto
    # notify-send "󰁹 Battery" "Refresh rate changed to 60Hz"
fi

