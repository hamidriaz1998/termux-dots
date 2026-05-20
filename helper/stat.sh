#!/usr/bin/env bash
set -uo pipefail

function stat() {

  local type="$2"
  local icon=""
  local border=""

  case "$type" in
    Success) icon="✅"; border="2" ;;
    Warning) icon="⚠️"; border="3" ;;
    Danger)  icon="❌"; border="1" ;;
    *)       icon="ℹ️"; border="4" ;;
  esac

  gum style --border=rounded --border-foreground="$border" --padding="0 1" --margin="0 1" \
    "$icon $1 — $3"

}
