#!/bin/sh

# Entrypoint for Lecton CLI

# Run the Python CLI and capture its output
output=$(python3 -m lectoncli.write_summary "$@")
exit_code=$?

# Always print to console
echo "$output"

# Write markdown to job summary if available
if [ -n "$GITHUB_STEP_SUMMARY" ]; then
    printf '%s\n' "$output" >> "$GITHUB_STEP_SUMMARY"
fi

exit $exit_code
