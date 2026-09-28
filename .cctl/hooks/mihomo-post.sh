#!/usr/bin/env bash
set -euo pipefail

dest=$3
if [ ! -f "$dest/ui/index.html" ]; then
    mkdir -p -- "$dest/ui"
    tar -xzf "$dest/ui.tar.gz" -C "$dest/ui"
    [ -f "$dest/ui/index.html" ]
fi
