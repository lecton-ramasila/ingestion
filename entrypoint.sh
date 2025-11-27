#!/bin/sh

# Run CLI and capture output
output=$(python3 -m lectoncli.write_summary "$@")

# Print to console
echo "$output"

# Append to summary if available
if [ -n "$GITHUB_STEP_SUMMARY" ]; then
    printf '%s\n' "$output" >> "$GITHUB_STEP_SUMMARY"
fi
