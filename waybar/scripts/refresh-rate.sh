#!/bin/bash

MONITOR="eDP-1"
RES="2880x1800"
MODES=("60.00" "120.00")  # Just the Hz parts for simplicity
STATE_FILE="/tmp/waybar_refresh_rate_index_${MONITOR}"

# Determine current index by matching actual refresh rate
CURRENT_RATE=$(hyprctl monitors | awk -v mon="$MONITOR" '
    $1 == "Monitor" && $2 == mon {found=1}
    found && /at / {split($0, a, "@"); rate=a[2]; gsub(/Hz.*/, "", rate); print rate; exit}
')

if [[ -z "$CURRENT_RATE" ]]; then
    echo "??Hz"
    exit 0
fi

CURRENT_HZ=$(printf "%.0f" "$CURRENT_RATE")

# Find current index
INDEX=0
for i in "${!MODES[@]}"; do
    if (( $(printf "%.0f" "${MODES[$i]}") == CURRENT_HZ )); then
        INDEX=$i
        break
    fi
done

echo "${CURRENT_HZ}Hz"

# On click: toggle to the *other* mode
if [[ "$1" == "click" ]]; then
    NEXT_INDEX=$(( (INDEX + 1) % ${#MODES[@]} ))
    NEXT_HZ="${MODES[$NEXT_INDEX]}"

    # Apply the change (adjust scale if yours is different, e.g., 1.5 or auto)
    hyprctl keyword monitor "$MONITOR,${RES}@${NEXT_HZ},0x0,2"

    # Update state (optional but keeps it consistent)
    echo "$NEXT_INDEX" > "$STATE_FILE"

    # Refresh waybar to update the displayed Hz immediately
    pkill -RTMIN+10 waybar
fi
