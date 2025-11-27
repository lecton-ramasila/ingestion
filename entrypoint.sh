#!/bin/sh

# Capture Docker output exactly like prod
output=$(docker run --rm $INPUT_OPTIONS $INPUT_IMAGE $INPUT_COMMAND)
exit_code=$?

# Print to console
echo "$output"

# Write markdown to summary
if [ -n "$GITHUB_STEP_SUMMARY" ]; then
    printf '%s\n' "$output" >> "$GITHUB_STEP_SUMMARY"
fi

exit $exit_code
