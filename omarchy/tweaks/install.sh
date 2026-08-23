#!/usr/bin/env bash

# FOR: Hardware Udev Rules (amd-igpu, nvidia-dgpu, atk-hub, integrated-webcam)
UDEV_DIR="/etc/udev/rules.d"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Find all .rules files in the current folder and subdirectories (e.g., fa507nu/udev/)
RULE_FILES=$(find "$SCRIPT_DIR" -type f -name "*.rules")

if [ -z "$RULE_FILES" ]; then
    echo "No .rules files found in $SCRIPT_DIR!"
    exit 1
fi

echo "$RULE_FILES" | while read -r RULE_FILE; do
    FILENAME=$(basename "$RULE_FILE")

    echo "Copying $FILENAME -> $UDEV_DIR/$FILENAME"
    sudo cp "$RULE_FILE" "$UDEV_DIR/$FILENAME"
    sudo chown root:root "$UDEV_DIR/$FILENAME"
    sudo chmod 644 "$UDEV_DIR/$FILENAME"
done

echo "Reloading udev rules..."
sudo udevadm control --reload-rules
sudo udevadm trigger

ls -l "$UDEV_DIR"

# TODO: Differ this with multiple setups