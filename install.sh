#!/bin/bash

# Installs ProtonTPR on host
# Tested on F43.20260101

# Verify executed as root
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit -1
fi

# Verify that the files aren't already there
if [ -f /usr/local/bin/protontpr ]; then
    echo "/usr/local/bin/protontpr already exists"
    exit -1
fi
if [ -f /etc/udev/rules.d/60-thrustmaster-tpr.rules ]; then
    echo "/etc/udev/rules.d/60-thrustmaster-tpr.rules already exists"
    exit -1
fi
if [ -f ~/.config/systemd/user/protontpr.service ]; then
    echo "~/.config/systemd/user/protontpr.service already exists"
    exit -1
fi
if [ ! -f protontpr ]; then
    echo "protontpr has not been compiled"
    exit -1
fi

# Add executable to /usr/local/bin
cp protontpr /usr/local/bin

# Add udev rule to udev
cp etc/udev/rules.d/60-thrustmaster-tpr.rules /etc/udev/rules.d
udevadm control --reload-rules

# Add service to services
cp usr/lib/systemd/system/protontpr.service ~/.config/systemd/user/
systemctl --user daemon-reload
systemctl --user enable protontpr
systemctl --user start protontpr

# Verify running
systemctl --user status protontpr.service
