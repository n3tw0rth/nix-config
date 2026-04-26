#!/usr/bin/env bash
set -euo pipefail

TMUX_BIN="${TMUX_BIN:-tmux}"
FZF_BIN="${FZF_BIN:-fzf-tmux}"

SESSION_NAME="$($TMUX_BIN ls 2>/dev/null | awk -F':' '{print $1}' | $FZF_BIN -p --reverse)"

if [ -n "${SESSION_NAME:-}" ]; then
  $TMUX_BIN switch-client -t "$SESSION_NAME"
fi
