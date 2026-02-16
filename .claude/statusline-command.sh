#!/bin/bash

# Read JSON input from stdin
input=$(cat)

# Extract data from JSON
hostname=$(hostname -s)
cwd=$(echo "$input" | jq -r '.workspace.current_dir')
model=$(echo "$input" | jq -r '.model.display_name')
version=$(echo "$input" | jq -r '.version')
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')

# Extract limit information (if available)
session_limit_pct=$(echo "$input" | jq -r '.limits.session.used_percentage // empty')
weekly_limit_pct=$(echo "$input" | jq -r '.limits.weekly.used_percentage // empty')

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

# Build session limit indicator if available
session_limit_info=""
if [ -n "$session_limit_pct" ]; then
    session_rounded=$(printf "%.0f" "$session_limit_pct")
    # Color based on usage: green <50%, yellow 50-80%, red >80%
    if (( $(echo "$session_limit_pct < 50" | bc -l) )); then
        color='\033[38;5;120m'  # Green
    elif (( $(echo "$session_limit_pct < 80" | bc -l) )); then
        color='\033[38;5;226m'  # Yellow
    else
        color='\033[38;5;196m'  # Red
    fi
    session_limit_info="${color}session: ${session_rounded}%$(printf '\033[0m')"
fi

# Build weekly limit indicator if available
weekly_limit_info=""
if [ -n "$weekly_limit_pct" ]; then
    weekly_rounded=$(printf "%.0f" "$weekly_limit_pct")
    # Color based on usage: green <50%, yellow 50-80%, red >80%
    if (( $(echo "$weekly_limit_pct < 50" | bc -l) )); then
        color='\033[38;5;120m'  # Green
    elif (( $(echo "$weekly_limit_pct < 80" | bc -l) )); then
        color='\033[38;5;226m'  # Yellow
    else
        color='\033[38;5;196m'  # Red
    fi
    weekly_limit_info="${color}weekly: ${weekly_rounded}%$(printf '\033[0m')"
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

if [ -n "$session_limit_info" ]; then
    printf ' %s' "$session_limit_info"
fi

if [ -n "$weekly_limit_info" ]; then
    printf ' %s' "$weekly_limit_info"
fi

printf '\n'
