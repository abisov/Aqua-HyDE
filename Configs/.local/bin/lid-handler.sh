#!/bin/bash
# Lid switch handler for clamshell mode
# Moves workspaces to external monitor before disabling laptop screen

case "$1" in
    close)
        # Get the external monitor (not eDP-1)
        EXT_MON=$(hyprctl monitors -j | jq -r '.[] | select(.name != "eDP-1") | .name' | head -1)
        
        if [ -n "$EXT_MON" ]; then
            # Move all workspaces from eDP-1 to external monitor
            hyprctl workspaces -j | jq -r '.[] | select(.monitor == "eDP-1") | .id' | while read ws; do
                hyprctl dispatch moveworkspacetomonitor "$ws $EXT_MON"
            done
            
            # Focus the external monitor
            hyprctl dispatch focusmonitor "$EXT_MON"
            
            # Disable laptop screen
            hyprctl keyword monitor "eDP-1, disable"
        fi
        ;;
    open)
        # Re-enable laptop screen
        hyprctl keyword monitor "eDP-1, preferred, auto, 1"
        ;;
esac
