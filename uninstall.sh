#!/bin/bash

# Removes ProtonTPR from host
# Tested on Bazzite F43.20260101

# Verify executed as root
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit -1
fi

# Remove service from services
systemctl --user stop protontpr
systemctl --user disable protontpr
rm ~/.config/systemd/user/protontpr.service

# Remove udev rule from udev
rm /etc/udev/rules.d/60-thrustmaster-tpr.rules
udevadm control --reload-rules

# Remove executable from /usr/bin
rm /usr/local/bin/protontpr


