#!/bin/bash

sudo systemctl stop mihomo.service
sudo systemctl disable mihomo.service
sudo rm -f /usr/lib/systemd/system/mihomo.service
sudo systemctl daemon-reload
sudo systemctl reset-failed

