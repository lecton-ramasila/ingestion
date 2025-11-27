#!/bin/sh
output=$(docker build -q -t lectoncli-image . && \
         docker run --rm lectoncli-image "$@")
exit_code=$?

echo "$output"

if [ -n "$GITHUB_STEP_SUMMARY" ]; then
    printf '%s\n' "$output" >> "$GITHUB_STEP_SUMMARY"
fi

if [ -n "$GITHUB_OUTPUT" ] && ! printf '%s\n' "$output" | grep -qE '^(#|\|)'; then
    echo "stdout=$output" >> "$GITHUB_OUTPUT"
fi

exit $exit_code
