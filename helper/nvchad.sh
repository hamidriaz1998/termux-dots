#!/usr/bin/env bash
set -uo pipefail

function NvChad() {

  gum style --border=rounded --border-foreground="4" --padding="0 1" \
    "📦 Installing Neovim Plugins (NvChad)"

  if [ -d $HOME/NvChad ]; then

    stat "FOUND" "Success" "NvChad folder exists"
    gum spin --title "Moving NvChad → .config/nvim ..." -- mv $HOME/NvChad $HOME/.config/nvim

    if [ -d $HOME/.config/nvim ]; then

      stat "SUCCESS" "Success" "NvChad moved to .config/nvim"
      stat "STARTING" "Warning" "Run 'nvim' to complete the NvChad setup"

    else

      stat "FAILED" "Danger" "Could not move NvChad to .config/nvim"

    fi

  else

    stat "NOT FOUND" "Danger" "NvChad folder not found"

  fi

}
