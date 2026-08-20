#!/bin/bash
sudo cp ./mihomo.service /usr/lib/systemd/system/
sudo systemctl enable mihomo.service
sudo systemctl daemon-reload
systemctl start mihomo.service
