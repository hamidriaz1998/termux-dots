#!/usr/bin/env bash
set -uo pipefail

function utility() {

  cp ~/.fonts/JetBrains\ Mono\ Medium\ Nerd\ Font\ Complete.ttf $PREFIX/share/fonts/TTF/ 2> /dev/null

  gum spin --title "Setting default shell to fish ..." -- chsh -s fish

  if [[ -f $PREFIX/etc/motd ]]; then

    mkdir -p $HOME/motd/
    mv $PREFIX/etc/motd $HOME/motd/motd.backup

  fi

  stat "SUCCESS" "Success" "Default shell set to fish"

}
