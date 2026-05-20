#!/usr/bin/env bash
set -uo pipefail

MYTERMUX_VERSION="0.6.2"

function alertFinish() {

  gum style --border=rounded --border-foreground="3" --padding="1 2" --margin="1" \
    "⚠️ Installation Complete" \
    "" \
    "Please restart Termux to apply all settings." \
    "" \
    "Run 'nvim' to complete the NvChad setup."

}

function alertNotification() {

  if ! command -v termux-notification &>/dev/null; then
    stat "SKIPPED" "Warning" "Termux:API not installed, skipping notification"
    return 0
  fi

  local IMAGE_PATH="${HOME}/.config/mytermux/alert/images"
  local IMAGE_FILE_NAME="finish.png"

  if [[ -f "${IMAGE_PATH}/${IMAGE_FILE_NAME}" ]]; then
    termux-notification --sound -t "myTermux v${MYTERMUX_VERSION} has been installed" --image-path "${IMAGE_PATH}/${IMAGE_FILE_NAME}"
  else
    termux-notification --sound -t "myTermux v${MYTERMUX_VERSION} has been installed"
  fi

}

function alertTorch() {

  if ! command -v termux-toast &>/dev/null; then
    stat "SKIPPED" "Warning" "Termux:API not installed, skipping toast"
    return 0
  fi

  termux-toast -b "#A8D7FE" -c "#373E4D" -g middle "myTermux v${MYTERMUX_VERSION} has been installed"

}


function mainAlert() {

  alertFinish
  alertNotification
  alertTorch

}
