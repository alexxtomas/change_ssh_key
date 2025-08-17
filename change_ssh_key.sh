#!/bin/bash

# Function to display usage information
function usage() {
    echo "Usage: $0 --key|-k [work|personal]"
    exit 1
}

# Check if the key argument is provided
if [[ $# -lt 2 ]]; then
    usage
fi

# Parse the arguments
while [[ $# -gt 0 ]]; do
    case "$1" in
        --key|-k)
            KEY_NAME="$2"
            shift 2
            ;;
        *)
            usage
            ;;
    esac
done

# Define SSH key paths
WORK_KEY="id_work"
PERSONAL_KEY="id_personal"
ADMIN_GLIMMER="id_itsglimmer"

# Determine which key to use
if [[ "$KEY_NAME" == "work" ]]; then
    SSH_KEY_PATH="$HOME/.ssh/$WORK_KEY"
elif [[ "$KEY_NAME" == "personal" ]]; then
    SSH_KEY_PATH="$HOME/.ssh/$PERSONAL_KEY"
elif [[ "$KEY_NAME" == "glimmer" ]]; then
    SSH_KEY_PATH="$HOME/.ssh/$ADMIN_GLIMMER"
else
    echo "Invalid key option: $KEY_NAME"
    usage
fi

# Add the SSH key to the keychain
ssh-add --apple-use-keychain "$SSH_KEY_PATH"
if [[ $? -ne 0 ]]; then
    echo "Failed to add SSH key to keychain."
    exit 1
fi

# Update ~/.ssh/config
CONFIG_PATH="$HOME/.ssh/config"
cat <<EOL > "$CONFIG_PATH"
# Added by OrbStack: 'orb' SSH host for Linux machines
# This only works if it's at the top of ssh_config (before any Host blocks).
# Comment this line if you don't want it to be added again.
Include ~/.orbstack/ssh/config

Host gea-pbx
HostName 34.45.242.180
Port 12141
User atomasllimos
IdentityFile ~/.ssh/gea
IdentitiesOnly yes
ClearAllForwardings yes
RequestTTY force

Host gea-asr
HostName 34.44.71.29
Port 1214
User atomasllimos
IdentityFile ~/.ssh/gea
IdentitiesOnly yes
ClearAllForwardings yes
RequestTTY force

# Added by change_ssh_key script
Host github.com
AddKeysToAgent yes
UseKeychain yes
IdentityFile $SSH_KEY_PATH
EOL

echo "SSH key successfully changed to $SSH_KEY_PATH"
