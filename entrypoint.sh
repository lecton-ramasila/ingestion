#!/bin/sh

# ----------------------------
# Entrypoint for Lecton CLI
# ----------------------------

# Set defaults for testing inside Actions
INPUT_IMAGE=${INPUT_IMAGE:-python:3.12-slim}
INPUT_COMMAND=${INPUT_COMMAND:-python3 -m lectoncli.write_summary "$@"}
INPUT_OPTIONS=${INPUT_OPTIONS:-}

# Run Docker and capture stdout + stderr
output=$(docker run --rm $INPUT_OPTIONS $INPUT_IMAGE sh -c "$INPUT_COMMAND" 2>&1)
exit_code=$?

# Always print to console
echo "$output"

# Write to GitHub Actions output only if non-markdown
if [ -n "$GITHUB_OUTPUT" ] && ! printf '%s\n' "$output" | grep -qE '^(#|\|)'; then
    echo "stdout=$output" >> "$GITHUB_OUTPUT"
fi

# Write markdown to GitHub Actions job summary if available
if [ -n "$GITHUB_STEP_SUMMARY" ]; then
    printf '%s\n' "$output" >> "$GITHUB_STEP_SUMMARY"
fi

exit $exit_code
