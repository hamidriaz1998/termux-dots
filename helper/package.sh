#!/usr/bin/env bash
set -euo pipefail

PACKAGES=(
  awesomeshot bat curl clang eza fzf git imagemagick
  inotify-tools lf neovim openssh
  neofetch termux-api tmux fish gum
)

function installPackages() {

  if [[ "$AUTO_ACCEPT" != true ]] && ! gum confirm "Install packages?"; then
    stat "ABORTED" "Warning" "Operation cancelled."
    return 1
  fi

  gum spin --title "Installing packages ..." -- pkg i -y "${PACKAGES[@]}" &>/dev/null

  for PACKAGE in "${PACKAGES[@]}"; do

    THIS_PACKAGE=$(pkg list-installed "$PACKAGE" 2> /dev/null | tail -n 1)
    CHECK_PACKAGE=${THIS_PACKAGE%/*}

    if [[ $CHECK_PACKAGE == "$PACKAGE" ]]; then
      stat "SUCCESS" "Success" "$PACKAGE installed"
    else
      stat "FAILED" "Danger" "$PACKAGE failed to install"
    fi

  done

}
