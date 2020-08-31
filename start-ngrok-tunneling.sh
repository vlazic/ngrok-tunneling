#!/bin/bash

source .env

TMUX_SESSION="NGROK"

# Close session if it already exists, discarding output
if tmux has-session -t $TMUX_SESSION 2>/dev/null; then
    tmux kill-session -t $TMUX_SESSION
fi

# Start new NGROK tmux session
tmux -2 new-session -d \
    -s $TMUX_SESSION -n "NGROK" \
    "ngrok http ${WEB_PORT} ; bash"

sleep 2
echo "This is public URL for: localhost:${WEB_PORT}/"
echo "$(curl -s localhost:4040/api/tunnels | jq -r .tunnels[0].public_url)/"
