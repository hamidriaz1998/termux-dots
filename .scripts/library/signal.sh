#!/usr/bin/env bash

function handleInterruptByUser() {

  pkill com.termux

  gum style --border=rounded --border-foreground="1" --padding="1 2" --margin="1" \
    "❌ ERROR — $1" \
    "" \
    "Press any key to exit..."

  setCursor on

  read -n 1 -s -r

  exit 1

}
