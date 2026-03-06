#!/bin/bash
# Run pico-aws agent with .env loaded
cd "$(dirname "$0")"
set -a
source .env 2>/dev/null || true
set +a
export PATH="$HOME/.local/bin:$PATH"
exec ./clawcubed "$@"
