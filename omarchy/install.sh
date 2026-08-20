#!/usr/bin/env bash

# FOR: omarchy-capture-screenshot, omarchy-capture-screenrecording
# Directories for screenshot and screen recorings
mkdir -p ~/.config/uwsm/env.d/
mkdir -p ~/Pictures/Screenshots/
mkdir -p ~/Videos/Recordings/

# FOR: Keybindings & Tilling (under Hyprland)
mkdir -p ~/.config/hypr/
cp -rf .config/omarchy/themes/pael ~/.config/omarchy/themes/pael

# FOR: Omarchy Theme
mkdir -p ~/.config/omarchy/themes/pael
cp -rf .config/hypr/pael.lua ~/.config/hypr/pael.lua

# TODO: Install powerctlconfig & cardwire 
# TODO: CTA
