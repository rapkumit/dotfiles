cat << 'EOF' > remove-asus-mic-fix.sh && chmod +x remove-asus-mic-fix.sh && ./remove-asus-mic-fix.sh
#!/bin/bash
set -e

echo "[-] Removing ALSA kernel module options..."
sudo rm -f /etc/modprobe.d/alsa-asus.conf

echo "[-] Removing WirePlumber soft-mixer rules..."
rm -f ~/.config/wireplumber/wireplumber.conf.d/50-asus-mic.conf

echo "[-] Restarting PipeWire services..."
systemctl --user restart wireplumber pipewire pipewire-pulse

echo "[✓] Fix removed! Reboot your system to revert back to defaults: sudo reboot"
EOF
