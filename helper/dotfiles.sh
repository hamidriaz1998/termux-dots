#!/usr/bin/env bash
set -uo pipefail

BACKUP_DOTFILES=(
  .autostart .aliases
  .config .colorscheme
  .fonts .local .scripts
  .termux .tmux.conf
)

DOTFILES=(
  .autostart .aliases
  .config .colorscheme
  .fonts .local .scripts
  .termux .tmux.conf
  .config/fish
)


function backupDotFiles() {

  if [[ "$AUTO_ACCEPT" != true ]] && ! gum confirm "Backup existing dotfiles?"; then
    stat "ABORTED" "Warning" "Operation cancelled."
    return 1
  fi

  for BACKUP_DOTFILE in "${BACKUP_DOTFILES[@]}"; do

    gum spin --title "Backing up $BACKUP_DOTFILE ..." -- sleep 0.5

    if [[ -d "$HOME/$BACKUP_DOTFILE" || -f "$HOME/$BACKUP_DOTFILE" ]]; then

      local timestamp
      timestamp="$(date +%Y.%m.%d-%H.%M.%S)"

      mv "${HOME}/${BACKUP_DOTFILE}" "${HOME}/${BACKUP_DOTFILE}.${timestamp}.backup"

      if [[ -d "${HOME}/${BACKUP_DOTFILE}.${timestamp}.backup" || -f "${HOME}/${BACKUP_DOTFILE}.${timestamp}.backup" ]]; then
        stat "SUCCESS" "Success" "Backed up $BACKUP_DOTFILE"
      else
        stat "FAILED" "Danger" "Failed to backup $BACKUP_DOTFILE"
      fi

    else
      stat "SKIPPED" "Warning" "$BACKUP_DOTFILE not found"
    fi

  done

}

function installDotFiles() {

  if [[ "$AUTO_ACCEPT" != true ]] && ! gum confirm "Install dotfiles?"; then
    stat "ABORTED" "Warning" "Operation cancelled."
    return 1
  fi

  for DOTFILE in "${DOTFILES[@]}"; do

    if [ "${DOTFILE}" == ".termux" ]; then

      gum spin --title "Installing $DOTFILE ..." -- cp -a "$DOTFILE" "$HOME"

      if [[ -d $HOME/$DOTFILE || -f $HOME/$DOTFILE ]]; then
        termux-reload-settings
        stat "SUCCESS" "Success" "Installed $DOTFILE"
      else
        stat "FAILED" "Danger" "Failed to install $DOTFILE"
      fi

    else

      gum spin --title "Installing $DOTFILE ..." -- cp -a "$DOTFILE" "$HOME"

      if [[ -d $HOME/$DOTFILE || -f $HOME/$DOTFILE ]]; then
        stat "SUCCESS" "Success" "Installed $DOTFILE"
      else
        stat "FAILED" "Danger" "Failed to install $DOTFILE"
      fi

    fi

  done

}
