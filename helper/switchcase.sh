#!/usr/bin/env bash
set -uo pipefail

function switchCase() {

  setCursor on

  if gum confirm "$1 $2?"; then
    ${3}
  else
    stat "ABORTED" "Warning" "Operation cancelled by user."
    exit 1
  fi

}
