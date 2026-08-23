#!/usr/bin/env bash

# FOR: Hardware Udev Rules (amd-igpu, nvidia-dgpu, atk-hub, integrated-webcam)
UDEV_DIR="/etc/udev/rules.d"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TWEAKS_DIR="$SCRIPT_DIR/tweaks"

if [ ! -d "$TWEAKS_DIR" ]; then
    echo "Directory $TWEAKS_DIR not found!"
    exit 1
fi

for RULE_FILE in "$TWEAKS_DIR"/*.rules; do
    [ -e "$RULE_FILE" ] || continue
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