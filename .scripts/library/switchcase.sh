#!/usr/bin/env bash

function switchCase() {

  setCursor on

  if gum confirm "$1 $2?"; then
    ${3}
  else
    stat "ABORTED" "Warning" "Operation cancelled."
  fi

}
