#!/bin/bash

# Redirect stderr of commands within the script to /dev/null
exec 2>/dev/null

# Check if bluetoothctl is available
if ! command -v bluetoothctl &>/dev/null; then
    printf '{"text": "ERR", "tooltip": "bluetoothctl command not found", "class": "error"}\n'
    exit 1
fi

# Check Bluetooth power status
if bluetoothctl show | grep -q "Powered: yes"; then
    icon=""
    # *** Temporarily simplified tooltip ***
    tooltip="BT On"
    class="on"
    text=""

    mapfile -t connected_devices < <(timeout 2 bluetoothctl devices Connected | grep Device)
    num_connected=${#connected_devices[@]}

    if [[ $num_connected -gt 0 ]]; then
        icon=""
        # *** Temporarily simplified tooltip ***
        tooltip="$num_connected Connected"
        class="connected"
        # text="$num_connected"
    fi

    # *** Use conditional printf to handle empty text gracefully ***
    if [[ -n "$text" ]]; then
        # Text is not empty, include the space
        printf '{"text": "%s %s", "tooltip": "%s", "class": "%s"}\n' "$icon" "$text" "$tooltip" "$class"
    else
        # Text is empty, omit the space
        printf '{"text": "%s", "tooltip": "%s", "class": "%s"}\n' "$icon" "$tooltip" "$class"
    fi

else
    # Bluetooth is Off
    icon="󰂲"
    # *** Temporarily simplified tooltip ***
    tooltip="BT Off"
    class="off"

    # Use the simpler printf here too (no text variable anyway)
    printf '{"text": "%s", "tooltip": "%s", "class": "%s"}\n' "$icon" "$tooltip" "$class"
fi

exit 0
