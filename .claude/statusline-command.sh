#!/bin/bash

# Read JSON input from stdin
input=$(cat)

# Extract data from JSON
hostname=$(hostname -s)
cwd=$(echo "$input" | jq -r '.workspace.current_dir')
model=$(echo "$input" | jq -r '.model.display_name')
version=$(echo "$input" | jq -r '.version')
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')

# Truncate CWD to last 3 components if path is long
truncated_cwd=$(echo "$cwd" | awk -F'/' '{
    if (NF > 3) {
        printf ".../%s/%s/%s", $(NF-2), $(NF-1), $NF
    } else {
        print $0
    }
}')

# Build usage indicator if available
usage_info=""
if [ -n "$used_pct" ]; then
    usage_rounded=$(printf "%.0f" "$used_pct")
    usage_info="$(printf '\033[38;5;141m')ctx: ${usage_rounded}%$(printf '\033[0m')"
fi

# Colors optimized for dark mode terminals:
# Cyan for hostname
# Green for directory
# Blue for model
# Magenta for version
# Purple for usage

printf '\033[38;5;51m'    # Bright cyan
printf '%s' "$hostname"
printf '\033[0m'          # Reset
printf ' '
printf '\033[38;5;120m'   # Bright green
printf '%s' "$truncated_cwd"
printf '\033[0m'
printf ' '
printf '\033[38;5;75m'    # Light blue
printf '[%s]' "$model"
printf '\033[0m'
printf ' '
printf '\033[38;5;213m'   # Pink/magenta
printf 'v%s' "$version"
printf '\033[0m'

if [ -n "$usage_info" ]; then
    printf ' %s' "$usage_info"
fi

printf '\n'
