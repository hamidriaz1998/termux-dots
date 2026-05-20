#!/usr/bin/env bash

function screenSize() {

  COLS=$(echo $COLUMNS)
  ROWS=$(echo $LINES)

  if [[ -n ${COLS} && -n ${ROWS} ]]; then

    if (( ${COLS} >= 101 && ${ROWS} >= 39 )); then

      ${1}

    else

      gum style --border=rounded --border-foreground="3" --padding="1 2" --margin="1" \
        "⚠️ Screen Too Small" \
        "" \
        "Please zoom out your terminal."

    fi

  else

    gum style --border=rounded --border-foreground="1" --padding="1 2" --margin="1" \
      "❌ Cannot Detect Screen" \
      "" \
      "Run \`export COLUMNS LINES\` first."

  fi

}
