#!/usr/bin/env bash

RED="\e[91m"
YELLOW="\e[93m"
GREEN="\e[92m"
DEFAULT="\e[39m"

user="xshin"
pass="xshin"

handle_ctrl_c() {

  pkill com.termux

  gum style --border=rounded --border-foreground="1" --padding="1 2" --margin="1" \
    "❌ Oops, you can't exit!" \
    "" \
    "Press Enter to return to login, or enter username/password to continue."

}

trap "handle_ctrl_c" 2

clear
while true; do

  gum style --border=rounded --border-foreground="4" --padding="1 2" --margin="1" \
    "Welcome to Termux!"

  username=$(gum input --placeholder "Username")

  if [[ "$username" == "$user" ]]; then

    password=$(gum input --placeholder "Password" --password)

    if [[ $password == $pass ]]; then
      gum style --border=rounded --border-foreground="2" --padding="1 2" --margin="1" \
        "✅ Login successful"
      sleep 2s
      clear
      break
    else
      gum style --border=rounded --border-foreground="1" --padding="1 2" --margin="1" \
        "❌ Wrong password"
      sleep 2s
      clear
    fi

  else

    gum style --border=rounded --border-foreground="3" --padding="1 2" --margin="1" \
      "⚠️ Wrong username"
    sleep 2s
    clear

  fi

done
