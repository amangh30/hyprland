#!/bin/bash

THRESHOLD=20
FLAG_FILE="/tmp/battery_alert_triggered"

BATTERY=$(cat /sys/class/power_supply/BAT0/capacity)
STATUS=$(cat /sys/class/power_supply/BAT0/status)

if [ "$BATTERY" -le "$THRESHOLD" ] && [ "$STATUS" = "Discharging" ]; then
    if [ ! -f "$FLAG_FILE" ]; then
        notify-send "Low Battery ⚠️" "Battery is at ${BATTERY}%"
        paplay /usr/share/sounds/freedesktop/stereo/alarm-clock-elapsed.oga
        touch "$FLAG_FILE"
    fi
else
    rm -f "$FLAG_FILE"
fi
