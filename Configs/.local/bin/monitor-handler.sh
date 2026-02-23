#!/bin/bash
# Monitor hotplug handler - reapplies wallpaper when monitor is added

handle() {
    case $1 in
        monitoradded*)
            # Extract monitor name from event (e.g., "monitoradded>>DP-2")
            monitor_name="${1#*>>}"
            
            # Wait for monitor to be ready
            sleep 1.5
            
            # Get current wallpaper path
            wallpaper_path="$(readlink -f ~/.cache/hyde/wall.set 2>/dev/null)"
            
            # Try HyDE's wallpaper script first, fallback to direct swww command
            if command -v wallpaper.sh &>/dev/null; then
                wallpaper.sh --start 2>/dev/null
            elif [[ -n "$wallpaper_path" && -f "$wallpaper_path" ]]; then
                # Apply wallpaper directly to the new monitor
                swww img "$wallpaper_path" --outputs "$monitor_name" --transition-type fade --transition-duration 0.4 2>/dev/null
            fi
            ;;
    esac
}

# Listen to Hyprland socket for events
socat -U - UNIX-CONNECT:"$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" | while read -r line; do
    handle "$line"
done
