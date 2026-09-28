#!/usr/bin/env bash
set -euo pipefail

asset_dir=$2
if [ -f "$HOME/.oh-my-zsh/oh-my-zsh.sh" ]; then
    printf 'cctl: Oh My Zsh already installed\n' >&2
elif [ -e "$HOME/.oh-my-zsh" ]; then
    printf 'cctl: Oh My Zsh directory exists but is incomplete; resolve it before installing\n' >&2
    exit 1
else
    command -v zsh >/dev/null || { printf 'cctl: zsh is required to install Oh My Zsh\n' >&2; exit 1; }
    command -v git >/dev/null || { printf 'cctl: git is required to install Oh My Zsh\n' >&2; exit 1; }
    printf 'cctl: installing Oh My Zsh from the bundled installer\n' >&2
    CHSH=no RUNZSH=no KEEP_ZSHRC=yes sh "$asset_dir/oh-my-zsh-install.sh" --unattended --keep-zshrc
fi
