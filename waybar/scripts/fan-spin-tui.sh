#!/bin/bash

# Clear screen once
clear

# Hide cursor
tput civis
trap "tput cnorm; clear; exit" INT TERM

# Spinning frames
frames=("|" "/" "—" "\\")

while true; do
    rpm=$(cat /sys/class/hwmon/hwmon7/fan1_input 2>/dev/null || echo 0)

    cols=$(tput cols)
    rows=$(tput lines)
    row=$((rows / 2))

    if [ "$rpm" -eq 0 ]; then
        text="󰈐 0 RPM"
        col=$(( (cols - ${#text}) / 2 ))
        printf "\033[%d;%dH%s" "$row" "$col" "$text"
        sleep 1
    else
         if [ "$rpm" -lt 1800 ]; then delay=0.45
        elif [ "$rpm" -lt 2200 ]; then delay=0.35
        elif [ "$rpm" -lt 2600 ]; then delay=0.3
        elif [ "$rpm" -lt 3000 ]; then delay=0.25
        elif [ "$rpm" -lt 3400 ]; then delay=0.2
        elif [ "$rpm" -lt 3800 ]; then delay=0.15
        elif [ "$rpm" -lt 4300 ]; then delay=0.1
        else delay=0.05
        fi


        for frame in "${frames[@]}"; do
            text=" $frame $rpm RPM"
            col=$(( (cols - ${#text}) / 2 ))
            printf "\033[%d;%dH%s" "$row" "$col" "$text"
            sleep "$delay"
        done
    fi
done
in
