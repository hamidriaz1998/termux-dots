#!/usr/bin/env bash
set -uo pipefail

FISH_THEMES=(
  lean
  classic
  full
  fresh
  rainbow
)

function installFishTheme() {

  if [[ "$AUTO_ACCEPT" != true ]] && ! gum confirm "Install Fish theme (Tide)?"; then
    stat "ABORTED" "Warning" "Operation cancelled."
    return 1
  fi

  local choices=()
  for FISH_THEME in "${FISH_THEMES[@]}"; do
    case "$FISH_THEME" in
      lean)     choices+=("$FISH_THEME — Minimal") ;;
      classic)  choices+=("$FISH_THEME — Traditional") ;;
      full)     choices+=("$FISH_THEME — Feature-rich") ;;
      fresh)    choices+=("$FISH_THEME — Clean") ;;
      rainbow)  choices+=("$FISH_THEME — Colorful") ;;
    esac
  done

  local selected=$(gum choose "${choices[@]}")
  local theme="${selected%% —*}"

  gum spin --title "Installing Tide via fisher ..." -- \
    fish -c "fisher install IlanCosman/tide" 2>/dev/null

  if [ $? -eq 0 ]; then
    stat "SUCCESS" "Success" "Tide installed"
  else
    stat "FAILED" "Danger" "Failed to install Tide"
  fi

}
