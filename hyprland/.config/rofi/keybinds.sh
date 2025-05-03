#!/bin/bash
#TODO figure out how to preserve hyprland variables so $terminal maps to correct value
HYPR_CONF="$HOME/.config/hypr/hyprland.conf"

# Extract lines starting with any bind type
mapfile -t BINDINGS < <(
    grep -E '^\s*bind[^=]*\s*=' "$HYPR_CONF" | while IFS= read -r line; do
        line="${line#*=}"
        line="$(echo "$line" | sed 's/^[ \t]*//;s/[ \t]*$//')"
        IFS=',' read -r modifier key rest <<<"$line"

        cmd=$(echo "$rest" | cut -d'#' -f1 | xargs)
        comment=$(echo "$rest" | grep -o '#.*' | sed 's/# *//')

        # Escape special characters for Pango
        esc() {
            echo "$1" | sed -e 's/&/\&amp;/g' -e 's/</\&lt;/g' -e 's/>/\&gt;/g'
        }

        esc_cmd=$(esc "$cmd")
        esc_comment=$(esc "$comment")
        esc_mod=$(esc "$modifier")
        esc_key=$(esc "$key")

        printf "<b>%s + %s</b>  <i>%s</i> <span color='gray'>%s</span>\n" "$esc_mod" "$esc_key" "$esc_comment" "$esc_cmd"
    done
)

# Show with rofi
CHOICE=$(printf '%s\n' "${BINDINGS[@]}" | rofi -dmenu -i -markup-rows -p "Hyprland Keybinds:")

# Extract the command from <span>
CMD=$(echo "$CHOICE" | sed -n "s/.*<span color='gray'>\(.*\)<\/span>.*/\1/p")

echo "$CHOICE"
echo "$CMD"

# Run command
if [[ "$CMD" == exec,* ]]; then
    real_cmd="${CMD#exec, }" # Strip "exec, " (note the space after the comma)
    eval "$real_cmd"         # Run the command using eval
else
    hyprctl dispatch "$CMD"
fi
