#!/bin/bash

source .env

# install dependencies
sudo apt install -y unzip jq curl wget
# download and configure ngrok
command -v ngrok >/dev/null 2>&1 || {
    # download ngrok based on architectures
    if [ "$(uname -m)" == 'x86_64' ]; then
        wget -c -O /tmp/ngrok.zip \
            https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip
    else
        wget -c -O /tmp/ngrok.zip \
            https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-arm64.zip
    fi

    # unzip it
    unzip /tmp/ngrok.zip

    # setup ngrok with your token from .env file
    ./ngrok authtoken "$NGROK_TOKEN"

    # move it to the /usr/local/bin
    sudo mv ngrok /usr/local/bin
}

# install latest version of ngrok
sudo ngrok update
