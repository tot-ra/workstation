#!/bin/bash
# Send Discord notification via Kimaki
# Usage: ./notify.sh "Message text"

set -e

MESSAGE="$1"

if [ -z "$MESSAGE" ]; then
    echo "Usage: $0 \"Your message here\""
    exit 1
fi

if [ -z "$DISCORD_CHANNEL_ID" ]; then
    echo "Error: DISCORD_CHANNEL_ID environment variable not set"
    exit 1
fi

npx -y kimaki send --channel "$DISCORD_CHANNEL_ID" --prompt "$MESSAGE" --notify-only
