#!/usr/bin/env bash
set -uo pipefail

source "${SCRIPT_DIR}/helper/stat.sh"
source "${SCRIPT_DIR}/helper/cursor.sh"

FISHER_PLUGINS=(
  IlanCosman/tide
  patrickf1/fzf.fish
)

REPOSITORY_LINKS=(
  https://github.com/jimeh/tmux-themepack
  https://github.com/NvChad/starter
)

REPOSITORY_FULL_NAME=(
  jimeh/tmux-themepack
  NvChad/starter
)

REPOSITORY_PATH=(
  $HOME/.tmux-themepack
  $HOME/NvChad
)

function installFisher() {

  if fish -c "type fisher" &>/dev/null; then
    stat "SKIPPED" "Info" "fisher already installed"
    return 0
  fi

  local log_file="/tmp/fisher-install.log"

  if gum spin --title "Installing fisher ..." -- \
    fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher" > "$log_file" 2>&1; then
    stat "SUCCESS" "Success" "fisher installed"
  else
    stat "FAILED" "Danger" "Failed to install fisher (see $log_file)"
    return 1
  fi

}

function installFisherPlugins() {

  if [[ ${#FISHER_PLUGINS[@]} -eq 0 ]]; then
    return 0
  fi

  local plugins_str="${FISHER_PLUGINS[*]}"
  local log_file="/tmp/fisher-plugins-install.log"

  if gum spin --title "Installing fisher plugins: $plugins_str ..." -- \
    fish -c "fisher install $plugins_str" > "$log_file" 2>&1; then
    stat "SUCCESS" "Success" "Fisher plugins installed"
  else
    stat "FAILED" "Danger" "Failed to install fisher plugins (see $log_file)"
    return 1
  fi

}

function cloneRepository() {

  if [[ "$AUTO_ACCEPT" != true ]] && ! gum confirm "Clone repositories?"; then
    stat "ABORTED" "Warning" "Operation cancelled."
    return 1
  fi

  installFisher
  installFisherPlugins

  for ((i=0; i<${#REPOSITORY_LINKS[@]}; i++)); do

    if [ -d "${REPOSITORY_PATH[i]}" ]; then
      gum spin --title "Updating ${REPOSITORY_FULL_NAME[i]} ..." -- \
        git -C "${REPOSITORY_PATH[i]}" pull --ff-only

      if [ $? -eq 0 ]; then
        stat "SUCCESS" "Success" "Updated ${REPOSITORY_FULL_NAME[i]}"
      else
        stat "FAILED" "Danger" "Failed to update ${REPOSITORY_FULL_NAME[i]}"
      fi
    else
      gum spin --title "Cloning ${REPOSITORY_FULL_NAME[i]} ..." -- \
        git clone --depth=1 "${REPOSITORY_LINKS[i]}" "${REPOSITORY_PATH[i]}"

      if [ -d "${REPOSITORY_PATH[i]}" ]; then
        stat "SUCCESS" "Success" "Cloned ${REPOSITORY_FULL_NAME[i]}"
      else
        stat "FAILED" "Danger" "Failed to clone ${REPOSITORY_FULL_NAME[i]}"
      fi
    fi

  done

}
