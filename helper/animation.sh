#!/usr/bin/env bash
set -uo pipefail

# Credits:
#   Bash Spinner : https://github.com/tlatsas/bash-spinner

# Author: xShin
#
# Display loading spinner using gum
#
# Usage:
#   1. Source this file on your shell script
#   2. Run your command wrapped in gum spin:
#      gum spin --title "Installing ..." -- sleep 2

function start_animation() {
  # Placeholder - actual spinning is done via gum spin in calling code
  setCursor off
}

function stop_animation() {
  setCursor on
}
