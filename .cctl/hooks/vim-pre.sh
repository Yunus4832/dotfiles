#!/usr/bin/env bash
set -euo pipefail

source_file=$2
dest=$3
vim_dir="$(dirname -- "$dest")/.vim"
mkdir -p -- "$vim_dir"
cp -a -- "$(dirname -- "$source_file")/.vim/." "$vim_dir/"
