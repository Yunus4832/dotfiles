#!/usr/bin/env bash
set -euo pipefail

dest=$3
repo=$(cd -- "$(dirname -- "$2")/.." && pwd)
plug_dir=${CONFIGCTL_VIM_PLUG_DIR:-$repo/vim/vim-plug}
plug_dir=${plug_dir//&/\\&}
plug_dir=${plug_dir//|/\\|}

sed -i "s|^let g:my_plug_dir = \".*\"$|let g:my_plug_dir = \"$plug_dir\"|" "$dest"
