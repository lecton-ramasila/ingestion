#!/bin/sh

# ----------------------------
# Entrypoint for Lecton CLI (Docker version)
# ----------------------------

# Capture Docker output (stdout + stderr)
output=$(docker run --rm $INPUT_OPTIONS $INPUT_IMAGE $INPUT_COMMAND 2>&1)
exit_code=$?

# Print to console
echo "$output"

# Write non-markdown to GitHub Actions output
if [ -n "$GITHUB_OUTPUT" ] && ! printf '%s\n' "$output" | grep -qE '^(#|\|)'; then
    echo "stdout=$output" >> "$GITHUB_OUTPUT"
fi

# Write markdown to GitHub Actions step summary if available
if [ -n "$GITHUB_STEP_SUMMARY" ]; then
    printf '%s\n' "$output" >> "$GITHUB_STEP_SUMMARY"
fi

exit $exit_code
