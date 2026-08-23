cat << 'EOF' > install-asus-mic-fix.sh && chmod +x install-asus-mic-fix.sh && ./install-asus-mic-fix.sh
#!/bin/bash
set -e

echo "[+] Applying ASUS FA507NU ALC256 kernel driver module..."
echo "options snd-hda-intel model=asus-headset" | sudo tee /etc/modprobe.d/alsa-asus.conf > /dev/null

echo "[+] Setting up WirePlumber soft-mixer override rules..."
mkdir -p ~/.config/wireplumber/wireplumber.conf.d/

cat << 'WP_EOF' > ~/.config/wireplumber/wireplumber.conf.d/50-asus-mic.conf
monitor.alsa.rules = [
  {
    matches = [
      {
        node.name = "~alsa_input.pci-.*"
      }
    ]
    actions = {
      update-props = {
        api.alsa.soft-mixer = true
      }
    }
  }
]
WP_EOF

echo "[+] Restarting PipeWire services..."
systemctl --user restart wireplumber pipewire pipewire-pulse

echo "[✓] Fix applied! Reboot your system to finish: sudo reboot"
EOF
