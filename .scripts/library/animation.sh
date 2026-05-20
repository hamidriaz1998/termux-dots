#!/usr/bin/env bash

# Author: xShin
#
# Display loading spinner using gum spin
#
# Usage:
#   1. Source this file on your shell script
#   2. Run your command wrapped in gum spin:
#      gum spin --title "Installing ..." -- your_command

function start_animation() {
  # No-op - gum spin handles everything inline
  setCursor off
}

function stop_animation() {
  setCursor on
}
